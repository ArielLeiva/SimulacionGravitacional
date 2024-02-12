extends Node2D

var ball = preload("res://scenes/balls.tscn")
var button_timer = preload("res://scenes/button_timer.tscn")
var mouse_pos = Vector2.ZERO

var add_mass = false
var sub_mass = false
var add_vol = false
var sub_vol = false
enum vals {addm, subm, addv, subv}

var actions = ["more_mass", "less_mass", "more_vol", "less_vol"]
var conds = [add_mass, sub_mass, add_vol, sub_vol]
var base_m = Transform2D()
var camera = Camera2D

func inside_camera(coord):
	return (coord.x <= 900 && coord.x > 50 && coord.y >= 0 && coord.y < 900)

func _ready():
	camera = get_tree().get_first_node_in_group("camera")

func _unhandled_input(event):
	if event.is_action_pressed("spawn"):
		mouse_pos = event.position
		if inside_camera(mouse_pos):
			var x = ball.instantiate()
			x.position = camera.camera_to_global(mouse_pos)
			print(x.position)
			x.mass = glob.new_mass
			x.proportion = glob.new_vol
			add_child(x)
			x.add_to_group("balls")
	elif event is InputEventKey and (event.keycode == KEY_SPACE and event.is_pressed()) or event.is_action_pressed("start_stop"):
		glob.attract = !glob.attract
	
	var i = 0
	for a in actions:
		if event.is_action_pressed(a) and !conds[i]:
			conds[i] = true
			var timer = button_timer.instantiate()
			timer.button_id = i
			add_child(timer)
		elif event.is_action_released(a):
			conds[i] = false
		i += 1


