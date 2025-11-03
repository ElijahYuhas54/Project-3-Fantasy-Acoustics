extends Area2D

var speed := 400.0
var direction = 1.0
var lifetime := 3.0
var note_type := 1
var is_powerful := false
var damage := 15.0

@onready var sprite := $Sprite2D
@onready var particles := $CPUParticles2D
@onready var collision := $CollisionShape2D

var note_textures := {
	1: preload("res://assets/sprites/song_1.png"),
	2: preload("res://assets/sprites/song_2.png"),
	3: preload("res://assets/sprites/song_3.png"),
	4: preload("res://assets/sprites/song_4.png")
}

func _ready():
	if sprite and note_type in note_textures:
		sprite.texture = note_textures[note_type]

	var colors := {
		1: Color(1.0, 0.3, 0.3),
		2: Color(0.3, 1.0, 0.3),
		3: Color(0.3, 0.3, 1.0),
		4: Color(1.0, 1.0, 0.3)
	}
	var color = colors.get(note_type, Color.WHITE)

	if particles:
		particles.color = color
		particles.emitting = true

	if is_powerful:
		scale = Vector2(2.0, 2.0)

	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

	await get_tree().create_timer(lifetime).timeout
	queue_free()

var process_time := 0.0

func _process(delta):
	process_time += delta
	if lifetime > 0:
		modulate.a = 1.0 - (process_time / lifetime)

func _physics_process(delta):
	if direction is Vector2:
		position += direction * speed * delta
	else:
		position.x += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		create_impact_effect()
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("silenced_area") and is_powerful:
		area.restore_sound()
		create_impact_effect()
	elif area.is_in_group("silence_projectile"):
		area.queue_free()
		create_impact_effect()
		queue_free()

func create_impact_effect():
	var effect = CPUParticles2D.new()
	get_parent().add_child(effect)
	effect.global_position = global_position
	effect.emitting = true
	effect.one_shot = true
	effect.amount = 20
	effect.lifetime = 0.5
	effect.speed_scale = 2.0
	effect.explosiveness = 0.8
	effect.color = sprite.modulate

	await get_tree().create_timer(1.0).timeout
	effect.queue_free()
