extends Area2D

@export var is_silenced := true
var restoration_progress := 0.0

@onready var visual := $Visual
@onready var crystal := $Visual/Crystal
@onready var silence_symbol := $Visual/SilenceSymbol
@onready var chains := $Visual/Chains
@onready var silence_particles := $SilenceParticles
@onready var restoration_particles := $RestorationParticles
@onready var label := $Label

func _ready():
	add_to_group("silenced_area")
	update_visual_state()

func _process(delta):
	if is_silenced and restoration_progress > 0:
		restoration_progress -= delta * 0.5
		update_visual_state()

func restore_sound():
	restoration_progress += 25.0

	if restoration_progress >= 100.0:
		is_silenced = false
		fully_restored()

	update_visual_state()

func fully_restored():
	# Massive restoration effect
	restoration_particles.emitting = true
	silence_particles.emitting = false

	# Hide silence symbols
	silence_symbol.visible = false
	chains.visible = false

	label.text = "SOUND RESTORED!"
	label.add_theme_color_override("font_color", Color(1.0, 1.0, 0.5))

	# Animate crystal glowing
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(crystal, "modulate", Color(2, 2, 3), 0.5)
	tween.tween_property(crystal, "scale", Vector2(1.3, 1.3), 0.5)

	tween.set_parallel(false)
	tween.tween_property(crystal, "modulate", Color(1.5, 1.5, 2), 0.3)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 2.0)

	await get_tree().create_timer(3.0).timeout
	queue_free()

func update_visual_state():
	if is_silenced:
		var progress_ratio = restoration_progress / 100.0

		# Update crystal appearance
		var crystal_color = Color(0.3 + progress_ratio * 0.5, 0.3 + progress_ratio * 0.5, 0.4 + progress_ratio * 0.6)
		crystal.modulate = crystal_color

		# Fade silence symbols as restoration progresses
		silence_symbol.modulate.a = 1.0 - progress_ratio
		chains.modulate.a = 1.0 - progress_ratio

		if restoration_progress > 0:
			label.text = "Restoring... %.0f%%" % restoration_progress
			label.add_theme_color_override("font_color", Color(0.5 + progress_ratio * 0.5, 0.9, 1.0))
		else:
			label.text = "Silenced"
			label.add_theme_color_override("font_color", Color(0.9, 0.3, 0.3))
	else:
		crystal.modulate = Color(1.5, 1.5, 2)
		silence_symbol.visible = false
		chains.visible = false
		label.text = ""
