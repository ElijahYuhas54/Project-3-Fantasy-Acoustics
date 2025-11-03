extends CharacterBody2D

# Player stats
var speed := 300.0
var jump_velocity := -500.0
var gravity := 980.0

# Health system
var health := 100.0
var max_health := 100.0
# Combat stats
var base_damage := 15.0
var powerful_damage_multiplier := 2.5

# Guitar mechanic
var guitar_active := false
var melody_sequence := []
var current_melody := []
var melody_buffer_time := 0.0
var max_melody_buffer := 2.0

# Sequence system for beam attack
var required_sequence := []
var input_sequence := []
var beam_ready := false
var sequence_length := 4

# Animation state
var facing_right := true
var is_playing_guitar := false
var is_dead := false

# References
@onready var sprite := $AnimatedSprite2D
@onready var guitar_particles := $GuitarParticles
@onready var projectile_spawn := $ProjectileSpawnPoint
@onready var guitar_visual := $GuitarVisual
@onready var sound_wave_scene := preload("res://scenes/sound_wave.tscn")

func _ready():
	add_to_group("player")
	guitar_particles.emitting = false
	sprite.play("idle")
	generate_new_sequence()

func _physics_process(delta):
	if is_dead:
		return

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		$SoundEffects.play_jump()

	# Movement
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

	# Jump animation
	if not is_on_floor() and not is_playing_guitar:
		if sprite.animation != "jump":
			sprite.play("jump")

	# Guitar input
	handle_guitar_input(delta)
	move_and_slide()
	update_hud()

func handle_guitar_input(delta):
	if Input.is_action_just_pressed("guitar_note_1"):
		play_note(1)
	elif Input.is_action_just_pressed("guitar_note_2"):
		play_note(2)
	elif Input.is_action_just_pressed("guitar_note_3"):
		play_note(3)
	elif Input.is_action_just_pressed("guitar_note_4"):
		play_note(4)

	if Input.is_action_just_pressed("play_melody"):
		if beam_ready:
			fire_beam_attack()
		else:
			show_feedback("Match the sequence first!", Color(1, 0.5, 0.3))

	if melody_buffer_time > 0:
		melody_buffer_time -= delta
		if melody_buffer_time <= 0:
			current_melody.clear()

func play_note(note_number: int):
	is_playing_guitar = true
	input_sequence.append(note_number)

	if guitar_visual:
		guitar_visual.visible = true
		guitar_visual.position = Vector2(20 if facing_right else -20, 0)
		guitar_visual.scale = Vector2(0.6 if facing_right else -0.6, 0.6)
		var attack_particles = guitar_visual.get_node_or_null("AttackParticles")
		if attack_particles:
			attack_particles.restart()

	guitar_particles.emitting = true
	spawn_sound_wave(note_number)  # ✅ Pass note number to projectile
	$SoundEffects.play_guitar_note(note_number)
	check_sequence_match()

	await get_tree().create_timer(0.3).timeout
	is_playing_guitar = false
	guitar_particles.emitting = false
	if guitar_visual:
		guitar_visual.visible = false

func spawn_sound_wave(note_number: int):
	var wave = sound_wave_scene.instantiate()
	get_parent().add_child(wave)
	wave.global_position = projectile_spawn.global_position
	wave.direction = 1 if facing_right else -1
	wave.note_type = note_number  # ✅ Correct texture based on note
	wave.damage = base_damage

func check_sequence_match():
	if input_sequence.size() > required_sequence.size():
		input_sequence.clear()
		show_feedback("Wrong! Try again...", Color(1, 0.3, 0.3))
		return

	for i in range(input_sequence.size()):
		if input_sequence[i] != required_sequence[i]:
			input_sequence.clear()
			show_feedback("Wrong note! Try again...", Color(1, 0.3, 0.3))
			return

	if input_sequence.size() == required_sequence.size():
		beam_ready = true
		show_feedback("SEQUENCE MATCHED! Press E to unleash!", Color(0.5, 1, 0.5))
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color(1.5, 1.5, 2.0), 0.2)
		tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.2)

func fire_beam_attack():
	beam_ready = false
	input_sequence.clear()
	generate_new_sequence()
	show_feedback("SONG BEAM!", Color(1, 1, 0.5))

	if guitar_visual:
		guitar_visual.visible = true
		guitar_visual.scale = Vector2(0.6, 0.6)

		# Create orbital motion around the player
		var orbit_radius = 40.0
		var spin_tween = create_tween()
		spin_tween.set_parallel(true)

		# Rotate the guitar itself
		spin_tween.tween_property(guitar_visual, "rotation", TAU * 3, 2.0)

		# Animate position in a circle (8 points around the player)
		var orbit_tween = create_tween()
		for i in range(9):  # 9 points to complete the circle (0 to 2*PI)
			var angle = (TAU / 8.0) * i
			var orbit_pos = Vector2(cos(angle), sin(angle)) * orbit_radius
			if i == 0:
				guitar_visual.position = orbit_pos
			else:
				orbit_tween.tween_property(guitar_visual, "position", orbit_pos, 2.0 / 8.0)

	guitar_particles.emitting = true
	guitar_particles.amount = 100
	guitar_particles.explosiveness = 1.0
	guitar_particles.lifetime = 1.5

	var beam_duration = 2.0
	var note_interval = 0.1
	var elapsed = 0.0
	while elapsed < beam_duration:
		var wave = sound_wave_scene.instantiate()
		get_parent().add_child(wave)
		wave.global_position = projectile_spawn.global_position
		wave.direction = 1 if facing_right else -1
		wave.is_powerful = true
		wave.note_type = randi() % 4 + 1
		wave.damage = base_damage * powerful_damage_multiplier
		wave.speed = 500.0
		wave.lifetime = 3.0
		elapsed += note_interval
		await get_tree().create_timer(note_interval).timeout

	restore_nearby_areas()
	await get_tree().create_timer(0.5).timeout
	guitar_particles.amount = 20
	guitar_particles.explosiveness = 0.5
	guitar_particles.lifetime = 1.0
	guitar_particles.emitting = false
	if guitar_visual:
		guitar_visual.visible = false
		guitar_visual.rotation = 0
		guitar_visual.position = Vector2.ZERO
		guitar_visual.scale = Vector2(0.6, 0.6)

func restore_nearby_areas():
	var areas = get_tree().get_nodes_in_group("silenced_area")
	for area in areas:
		if global_position.distance_to(area.global_position) < 400:
			area.restore_sound()

func generate_new_sequence():
	required_sequence.clear()
	for i in range(sequence_length):
		required_sequence.append(randi() % 4 + 1)

func show_feedback(text: String, color: Color = Color(1, 1, 0.5)):
	var label = get_node_or_null("../UI/FeedbackLabel")
	if label:
		label.text = text
		label.modulate = color
		label.modulate.a = 1.0
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 0.0, 2.0)

func update_hud():
	var health_bar = get_node_or_null("../UI/HUD/HealthPanel/VBoxContainer/HealthBar")
	if health_bar:
		health_bar.value = health

	var sequence_display = get_node_or_null("../UI/HUD/HealthPanel/VBoxContainer/SequenceDisplay")
	if sequence_display:
		var display_text = ""
		for i in range(required_sequence.size()):
			if i < input_sequence.size():
				display_text += "[color=#5f5]%d[/color] " % required_sequence[i]
			else:
				display_text += "%d " % required_sequence[i]
		sequence_display.text = display_text.strip_edges()
		sequence_display.set("bbcode_enabled", true)

func take_damage(amount: float):
	if is_dead:
		return
	health -= amount
	health = max(health, 0)
	show_feedback("-%d HP!" % amount, Color(1, 0.3, 0.3))
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(2, 0.5, 0.5), 0.1)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.1)
	if health <= 0:
		die()

func die():
	is_dead = true
	show_feedback("DEFEATED!", Color(1, 0, 0))
	sprite.play("idle")
	velocity = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 2.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
