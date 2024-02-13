extends Sprite2D

var camera = Camera2D

func _ready():
	camera = get_tree().get_first_node_in_group("camera")

func _process(_delta):
	scale = Vector2(glob.new_vol, glob.new_vol) * camera.zoom.x
