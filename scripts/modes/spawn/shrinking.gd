extends Node2D

var enabled = false
var barycenter = Vector2.ZERO
var center_vel = Vector2.ZERO
var rot_vel = 0.0
var masses = 0.0
var volumes = 0.0
var camera = null

func update_barycenter():
	barycenter = Vector2.ZERO
	center_vel = Vector2.ZERO
	rot_vel = 0.0
	masses = 0.0
	volumes = 0
	
	var bodies = get_tree().get_nodes_in_group("selected")
	for body in bodies:
		if body.is_in_group("balls"):
			barycenter += body.position * body.mass
			volumes += body.proportion ** 2
			center_vel += body.linear_velocity * body.mass
			rot_vel += body.angular_velocity * body.mass
			masses += body.mass
		else:
			print("That's not a ball")
	if masses != 0.0:
		barycenter /= masses
		center_vel /= masses
		rot_vel /= masses
		volumes = sqrt(volumes)
	else: 
		barycenter = camera.offset
	
	return !bodies.is_empty()

func deactivate():
	enabled = false
	visible = false
	masses = 0.0
	volumes = 0.0
	set_process(false)
	set_physics_process(false)

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_tree().get_first_node_in_group("camera")
	deactivate()

func _unhandled_input(event):
	if event.is_action_pressed("shrink"):
		if update_barycenter():
			for body in get_tree().get_nodes_in_group("selected"):
				body.remove_from_group("selected")
				body.queue_free()
			get_parent().spawn_ball(barycenter, masses, volumes, center_vel, rot_vel, true)
			

