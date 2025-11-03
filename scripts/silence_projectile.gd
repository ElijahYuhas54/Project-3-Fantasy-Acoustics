extends Area2D

var speed := 200.0
var direction := Vector2.RIGHT
var lifetime := 5.0
var damage := 15

@onready var sprite := $Sprite2D
@onready var particles := $CPUParticles2D

func _ready():
	add_to_group("silence_projectile")

	# Visual setup - dark, ominous
	sprite.modulate = Color(0.1, 0.1, 0.1)

	if particles:
		particles.color = Color(0.2, 0.2, 0.2)
		particles.emitting = true

	# Signals
	body_entered.connect(_on_body_entered)

	# Self-destruct
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	position += direction * speed * delta

	# Rotate for effect
	rotation += delta * 3.0

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
		create_impact()
		queue_free()
	elif body is TileMap or body.is_in_group("terrain"):
		create_impact()
		queue_free()

func create_impact():
	var effect = CPUParticles2D.new()
	get_parent().add_child(effect)
	effect.global_position = global_position
	effect.emitting = true
	effect.one_shot = true
	effect.amount = 15
	effect.lifetime = 0.3
	effect.explosiveness = 1.0
	effect.color = Color(0.1, 0.1, 0.1)

	await get_tree().create_timer(0.5).timeout
	effect.queue_free()
