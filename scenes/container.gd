extends Node2D

var camera = Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_tree().get_first_node_in_group("camera")
	if !camera.limited_camera:
		for x in get_tree().get_nodes_in_group("collisions"):
			x.disabled = true
