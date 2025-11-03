extends CharacterBody2D

# Player stats
var speed := 300.0
var jump_velocity := -500.0
var gravity := 980.0

# Health system
var health := 100.0
var max_health := 100.0

# Combat stats
var base_damage := 15.0  # Base damage for sound waves
var powerful_damage_multiplier := 2.5  # Restoration spell multiplier

# Guitar mechanic
var guitar_active := false
var melody_sequence := []
var current_melody := []
var melody_buffer_time := 0.0
var max_melody_buffer := 2.0

# Sound restoration power (renamed from sound_power to energy)
var energy := 0.0
var max_energy := 100.0
var energy_regen := 5.0  # Energy per second

# Animation state
var facing_right := true
var is_playing_guitar := false
var is_dead := false

# References
@onready var sprite := $AnimatedSprite2D
@onready var guitar_particles := $GuitarParticles
@onready var projectile_spawn := $ProjectileSpawnPoint
@onready var sound_wave_scene := preload("res://scenes/sound_wave.tscn")

func _ready():
	guitar_particles.emitting = false
	sprite.play("idle")

func _physics_process(delta):
	if is_dead:
		return

	# Regenerate energy over time
	energy = min(energy + energy_regen * delta, max_energy)

	# Handle gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		$SoundEffects.play_jump()

	# Handle horizontal movement
	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * speed
		facing_right = direction > 0
		sprite.flip_h = not facing_right

		if is_on_floor() and not is_playing_guitar:
			if sprite.animation != "walk":
				sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor() and not is_playing_guitar:
			if sprite.animation != "idle":
				sprite.play("idle")

	# Play jump animation when in air
	if not is_on_floor() and not is_playing_guitar:
		if sprite.animation != "jump":
			sprite.play("jump")

	# Handle guitar playing
	handle_guitar_input(delta)

	move_and_slide()

	# Update UI
	update_hud()

func handle_guitar_input(delta):
	# Check for individual note inputs
	if Input.is_action_just_pressed("guitar_note_1"):
		play_note(1)
	elif Input.is_action_just_pressed("guitar_note_2"):
		play_note(2)
	elif Input.is_action_just_pressed("guitar_note_3"):
		play_note(3)
	elif Input.is_action_just_pressed("guitar_note_4"):
		play_note(4)

	# Play complete melody
	if Input.is_action_just_pressed("play_melody") and energy >= 20.0:
		play_restoration_melody()

	# Melody buffer timeout
	if melody_buffer_time > 0:
		melody_buffer_time -= delta
		if melody_buffer_time <= 0:
			current_melody.clear()

func play_note(note_number: int):
	is_playing_guitar = true

	# Add note to current melody
	current_melody.append(note_number)
	melody_buffer_time = max_melody_buffer

	# Visual feedback
	guitar_particles.emitting = true
	spawn_sound_wave(note_number)

	# Play sound
	$SoundEffects.play_guitar_note(note_number)

	# Check if melody matches any pattern
	check_melody_patterns()

	# Reset after brief delay
	await get_tree().create_timer(0.2).timeout
	is_playing_guitar = false
	guitar_particles.emitting = false

func spawn_sound_wave(note_number: int):
	var wave = sound_wave_scene.instantiate()
	get_parent().add_child(wave)
	# Spawn from projectile spawn point (center of character)
	wave.global_position = projectile_spawn.global_position
	wave.direction = 1 if facing_right else -1
	wave.note_type = note_number
	wave.damage = base_damage  # Apply player's damage stat

func check_melody_patterns():
	# Check for restoration melody: 1-2-3-4
	if current_melody.size() == 4:
		if current_melody == [1, 2, 3, 4]:
			gain_energy(10.0)
			show_feedback("Perfect Melody! +10 Energy", Color(0.5, 1, 0.5))
		elif current_melody == [4, 3, 2, 1]:
			gain_energy(15.0)
			show_feedback("Harmonic Reversal! +15 Energy", Color(0.5, 1, 1))
		elif current_melody == [1, 3, 2, 4]:
			gain_energy(8.0)
			show_feedback("Nice Rhythm! +8 Energy", Color(0.8, 1, 0.5))
		else:
			show_feedback("Keep trying...", Color(0.7, 0.7, 0.7))

		current_melody.clear()

func play_restoration_melody():
	energy -= 20.0

	# Visual and audio feedback
	show_feedback("RESTORATION SPELL!", Color(1, 1, 0.5))
	guitar_particles.emitting = true
	guitar_particles.amount = 50
	guitar_particles.explosiveness = 1.0

	# Spawn powerful sound waves in all directions
	for i in range(8):
		await get_tree().create_timer(0.1).timeout
		var wave = sound_wave_scene.instantiate()
		get_parent().add_child(wave)
		var angle = i * PI / 4.0
		# Spawn from center of character
		wave.global_position = projectile_spawn.global_position
		wave.direction = Vector2(cos(angle), sin(angle))
		wave.is_powerful = true
		wave.damage = base_damage * powerful_damage_multiplier  # Powerful damage
		wave.speed = 500.0

	# Restore nearby silenced areas
	restore_nearby_areas()

	# Reset particles
	await get_tree().create_timer(0.5).timeout
	guitar_particles.amount = 20
	guitar_particles.explosiveness = 0.5
	guitar_particles.emitting = false

func restore_nearby_areas():
	var areas = get_tree().get_nodes_in_group("silenced_area")
	for area in areas:
		if global_position.distance_to(area.global_position) < 400:
			area.restore_sound()

func gain_energy(amount: float):
	energy = min(energy + amount, max_energy)

	# Visual feedback
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1.5, 1.5, 2.0), 0.2)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.2)

func show_feedback(text: String, color: Color = Color(1, 1, 0.5)):
	var label = get_node_or_null("../UI/FeedbackLabel")
	if label:
		label.text = text
		label.modulate = color
		label.modulate.a = 1.0
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 0.0, 2.0)

func update_hud():
	# Update health bar
	var health_bar = get_node_or_null("../UI/ControlPanel/VBoxContainer/HealthBar")
	if health_bar:
		health_bar.value = health

	# Update energy bar
	var energy_bar = get_node_or_null("../UI/ControlPanel/VBoxContainer/EnergyBar")
	if energy_bar:
		energy_bar.value = energy

func take_damage(amount: float):
	if is_dead:
		return

	health -= amount
	health = max(health, 0)

	# Visual feedback
	show_feedback("-%.0f HP!" % amount, Color(1, 0.3, 0.3))
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(2, 0.5, 0.5), 0.1)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.1)

	# Check for death
	if health <= 0:
		die()

func die():
	is_dead = true
	show_feedback("DEFEATED!", Color(1, 0, 0))
	sprite.play("idle")
	velocity = Vector2.ZERO

	# Fade out
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 2.0)
	await tween.finished

	# Restart scene after delay
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
