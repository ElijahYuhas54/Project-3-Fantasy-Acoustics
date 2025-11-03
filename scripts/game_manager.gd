extends Node2D

@onready var portal_scene := preload("res://scenes/portal.tscn")
var portal_spawn_position := Vector2(1680, 740)  # Inside the ruins at ground level
var portal_spawned := false

func _ready():
	# Check for enemies periodically
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.timeout.connect(check_for_portal_spawn)
	timer.start()

func check_for_portal_spawn():
	if portal_spawned:
		return

	# Check if all enemies are defeated
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() == 0:
		spawn_portal()

func spawn_portal():
	portal_spawned = true

	# Spawn portal
	var portal = portal_scene.instantiate()
	add_child(portal)
	portal.global_position = portal_spawn_position

	# Show feedback
	var feedback_label = get_node_or_null("UI/FeedbackLabel")
	if feedback_label:
		feedback_label.text = "Portal Opened!"
		feedback_label.modulate = Color(0.8, 0.6, 1)
		feedback_label.modulate.a = 1.0
		var tween = create_tween()
		tween.tween_property(feedback_label, "modulate:a", 0.0, 3.0)
