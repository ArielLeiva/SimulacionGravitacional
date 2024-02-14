extends Node2D

@onready var arrow = $Arrow
var ball = preload("res://scenes/balls.tscn")
var button_timer = preload("res://scenes/button_timer.tscn")
var clicked_pos = Vector2.ZERO
var global_clicked_pos = Vector2.ZERO
var click_held: bool = false
# For an initial velocity
var init_vector = Vector2.ZERO

var fast_forward = false
var add_mass = false
var sub_mass = false
var add_vol = false
var sub_vol = false
enum vals {addm, subm, addv, subv}

var actions = ["more_mass", "less_mass", "more_vol", "less_vol"]
var conds = [add_mass, sub_mass, add_vol, sub_vol]
var base_m = Transform2D()
var camera = Camera2D

func _ready():
	camera = get_tree().get_first_node_in_group("camera")

func _unhandled_input(event):
	if event.is_action_pressed("spawn"):
		clicked_pos = event.position
		global_clicked_pos = camera.camera_to_global(clicked_pos)
		if camera.inside_camera(clicked_pos) and camera.inside_container(global_clicked_pos):
			click_held = true
			arrow.position = global_clicked_pos
			arrow.visible = true
	elif event is InputEventKey and (event.keycode == KEY_SPACE and event.is_pressed()) or event.is_action_pressed("start_stop"):
		glob.attract = !glob.attract
	if event.is_action_pressed("fast_forward"):
		Engine.time_scale *= 2
	elif event.is_action_pressed("slow_forward"):
		Engine.time_scale /= 2
	elif event.is_action_pressed("reset_speed"):
		Engine.time_scale = 1
	elif event.is_action_pressed("restart_scene"):
		get_tree().reload_current_scene()
	
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

func _process(_delta):
	
	if Input.is_action_pressed("r_click"):
		arrow.visible = false	
		click_held = false
	# Ball initial velocity set
	elif click_held:
		if Input.is_action_pressed("l_click"):
			var present_click = get_viewport().get_mouse_position()
			init_vector = present_click - clicked_pos
			arrow.look_and_scale(init_vector / camera.zoom.x)
		elif Input.is_action_just_released("l_click"):
			var x = ball.instantiate()
			x.position = global_clicked_pos
			x.mass = glob.new_mass
			x.proportion = glob.new_vol
			x.linear_velocity = init_vector / camera.zoom.x
			add_child(x)
			x.add_to_group("balls")
			# Hide arrow
			arrow.visible = false
			click_held = false
