extends CanvasLayer

@onready var restart_button := $Panel/VBoxContainer/ButtonContainer/RestartButton

func _ready():
	# Connect restart button
	restart_button.pressed.connect(_on_restart_pressed)

	# Fade in animation
	var panel = $Panel
	panel.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.5)

func _on_restart_pressed():
	# Remove win screen and unpause
	get_tree().paused = false
	queue_free()

	# Reload scene
	get_tree().reload_current_scene()
