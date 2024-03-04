extends Node2D

var enabled = false
var barycenter = Vector2.ZERO
var masses = 0.0
var camera = null
var ui = null

func deactivate():
	enabled = false
	visible = false
	set_process(false)
	set_physics_process(false)

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_tree().get_first_node_in_group("camera")
	ui = get_tree().get_first_node_in_group("UI")
	deactivate()

func update_barycenter():
	masses = 0
	barycenter = Vector2.ZERO
	var bodies = get_tree().get_nodes_in_group("selected")
	for body in bodies:
		if body.is_in_group("balls"):
			barycenter += body.position * body.mass
			masses += body.mass
		else:
			print("That's not a ball")
	if masses != 0:
		barycenter /= masses
	else: 
		barycenter = camera.offset
	
	return !bodies.is_empty()
	
func _unhandled_input(event):
	if event.is_action_pressed("follow"):
		enabled = !enabled
		visible = !visible
		set_process(enabled)
		set_physics_process(enabled)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# If there are bodies selected, set the camera to follow the center of mass
	if update_barycenter():
		position = barycenter
		if enabled:
			if camera:
				camera.offset = position
	else:
		if ui:
			ui.update_ui()
		deactivate()

