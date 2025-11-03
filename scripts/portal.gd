extends Area2D

@onready var visual := $Visual
@onready var label := $Label
@onready var win_screen_scene := preload("res://scenes/win_screen.tscn")

var win_screen_shown := false

func _ready():
	body_entered.connect(_on_body_entered)

	# Animate the portal
	animate_portal()

	# Fade in
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

func animate_portal():
	# Rotate the portal rings
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(visual, "rotation", TAU, 3.0)

	# Pulse effect
	var pulse_tween = create_tween()
	pulse_tween.set_loops()
	pulse_tween.tween_property(visual, "scale", Vector2(1.1, 1.1), 1.0)
	pulse_tween.tween_property(visual, "scale", Vector2(1.0, 1.0), 1.0)

func _on_body_entered(body):
	if body.is_in_group("player") and not win_screen_shown:
		# Only allow portal entry if all enemies are defeated
		var enemies = get_tree().get_nodes_in_group("enemy")
		if enemies.size() == 0:
			show_victory_screen()

func show_victory_screen():
	win_screen_shown = true

	# Freeze the game
	get_tree().paused = true

	# Instantiate and add win screen
	var win_screen = win_screen_scene.instantiate()
	get_tree().root.add_child(win_screen)
