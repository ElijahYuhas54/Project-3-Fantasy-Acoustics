extends ParallaxBackground

var scroll_speed := 20.0

@onready var layer1 := $ParallaxLayer1
@onready var layer2 := $ParallaxLayer2
@onready var layer3 := $ParallaxLayer3

func _ready():
	# Set different motion scales for depth
	if layer1:
		layer1.motion_scale = Vector2(0.1, 0.1)
	if layer2:
		layer2.motion_scale = Vector2(0.3, 0.3)
	if layer3:
		layer3.motion_scale = Vector2(0.6, 0.6)

func _process(delta):
	# Gentle auto-scroll for atmosphere
	scroll_offset.x -= scroll_speed * delta
