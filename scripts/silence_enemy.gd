extends CharacterBody2D

var health := 30
var speed := 100.0
var gravity := 980.0
var direction := -1
var attack_range := 400.0
var attack_cooldown := 2.0
var attack_timer := 0.0

@onready var sprite := $Sprite2D
@onready var ray_left := $RayLeft
@onready var ray_right := $RayRight
@onready var detection_area := $DetectionArea
@onready var health_bar := $HealthBarContainer/HealthBar
@onready var silence_projectile_scene := preload("res://scenes/silence_projectile.tscn")

var player_target = null

func _ready():
	add_to_group("enemy")
	detection_area.body_entered.connect(_on_detection_body_entered)
	detection_area.body_exited.connect(_on_detection_body_exited)

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# AI behavior
	if player_target:
		ai_chase_player(delta)
	else:
		ai_patrol()

	# Update facing direction
	if velocity.x != 0:
		sprite.scale.x = -1 if velocity.x < 0 else 1

	move_and_slide()

	# Check for edge/wall detection
	if is_on_floor():
		if (direction < 0 and not ray_left.is_colliding()) or \
		   (direction > 0 and not ray_right.is_colliding()):
			direction *= -1

func ai_patrol():
	velocity.x = direction * speed * 0.5

func ai_chase_player(delta):
	if player_target:
		var distance = player_target.global_position.distance_to(global_position)

		if distance < attack_range:
			# Stop and attack
			velocity.x = 0
			attack_timer -= delta

			if attack_timer <= 0:
				shoot_silence_projectile()
				attack_timer = attack_cooldown
		else:
			# Chase player
			var dir_to_player = sign(player_target.global_position.x - global_position.x)
			velocity.x = dir_to_player * speed

func shoot_silence_projectile():
	if silence_projectile_scene:
		var projectile = silence_projectile_scene.instantiate()
		get_parent().add_child(projectile)
		projectile.global_position = global_position
		var dir_to_player = (player_target.global_position - global_position).normalized()
		projectile.direction = dir_to_player

func take_damage(amount: float):
	health -= amount

	# Update health bar
	if health_bar:
		health_bar.value = health

	# Enhanced hurt animation
	var tween = create_tween()
	tween.set_parallel(true)

	# Flash red
	tween.tween_property(sprite, "modulate", Color(3, 0.3, 0.3), 0.1)

	# Scale bounce
	tween.tween_property(sprite, "scale", Vector2(1.2, 0.8), 0.1)

	# Knockback effect
	velocity.y = -150

	tween.set_parallel(false)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.15)
	tween.parallel().tween_property(sprite, "scale", Vector2(1, 1), 0.15)

	# Hurt particles
	spawn_hurt_particles()

	# Show damage number
	show_damage_number(amount)

	if health <= 0:
		die()

func spawn_hurt_particles():
	var particles = CPUParticles2D.new()
	add_child(particles)
	particles.position = Vector2(0, -20)
	particles.emitting = true
	particles.one_shot = true
	particles.amount = 15
	particles.lifetime = 0.4
	particles.explosiveness = 1.0
	particles.direction = Vector2(0, -1)
	particles.spread = 180.0
	particles.initial_velocity_min = 80.0
	particles.initial_velocity_max = 150.0
	particles.gravity = Vector2(0, 200)
	particles.scale_amount_min = 3.0
	particles.scale_amount_max = 6.0
	particles.color = Color(1, 0.2, 0.2, 1)

	await get_tree().create_timer(0.5).timeout
	particles.queue_free()

func show_damage_number(amount: float):
	var label = Label.new()
	add_child(label)
	label.text = "-%.0f" % amount
	label.position = Vector2(-15, -40)
	label.add_theme_font_size_override("font_size", 16)
	label.add_theme_color_override("font_color", Color(1, 0.3, 0.3))

	# Animate damage number
	var tween = create_tween()
	tween.tween_property(label, "position:y", label.position.y - 30, 0.8)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 0.8)

	await tween.finished
	label.queue_free()

func die():
	# Death effect
	var particles = CPUParticles2D.new()
	get_parent().add_child(particles)
	particles.global_position = global_position
	particles.emitting = true
	particles.one_shot = true
	particles.amount = 30
	particles.lifetime = 1.0
	particles.explosiveness = 0.9
	particles.color = Color(0.2, 0.2, 0.2)

	queue_free()

func _on_detection_body_entered(body):
	if body.is_in_group("player"):
		player_target = body

func _on_detection_body_exited(body):
	if body == player_target:
		player_target = null
