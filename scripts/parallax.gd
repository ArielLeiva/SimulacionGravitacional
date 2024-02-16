extends ParallaxBackground

var camera = Camera2D

func _ready():
	camera = get_tree().get_first_node_in_group("camera")
	if camera:
		scroll_offset = camera.offset
