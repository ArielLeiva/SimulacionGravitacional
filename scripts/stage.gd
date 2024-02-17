extends Node2D

signal mode_updated

var button_timer = preload("res://scenes/button_timer.tscn")
var fast_forward = false
var add_mass = false
var sub_mass = false
var add_vol = false
var sub_vol = false
enum vals {addm, subm, addv, subv}

var actions = ["more_mass", "less_mass", "more_vol", "less_vol"]
var conds = [add_mass, sub_mass, add_vol, sub_vol]
var ui = null

func _ready():
	ui = get_tree().get_first_node_in_group("UI")
	mode_updated.emit()

func _unhandled_input(event):
	if !ui.visible and event.is_action_pressed("l_click"):
		if !ui.inside_ui(event.position): 
			ui.visible = true		
	elif event.is_action_pressed("select_mode"):
		glob.mode = glob.states.SELECT_MODE
		mode_updated.emit()
	elif event.is_action_pressed("spawn_mode"):
		glob.mode = glob.states.SPAWN_MODE
		mode_updated.emit()
	elif event.is_action_pressed("drag_mode"):
		glob.mode = glob.states.DRAG_MODE
		mode_updated.emit()
	elif event.is_action_pressed("gravity"):
		glob.attract = !glob.attract
	if event.is_action_pressed("fast_forward"):
		Engine.time_scale *= 2
	elif event.is_action_pressed("slow_forward"):
		Engine.time_scale /= 2
	elif event.is_action_pressed("reset_speed"):
		Engine.time_scale = 1
		get_tree().paused = false
	elif event.is_action_pressed("restart_scene"):
		glob.default()
		get_tree().reload_current_scene()
	elif event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
	elif event.is_action_pressed("hide_ui"):
		ui.visible = !ui.visible
	
	# TODO: Redesign this hardcoded part
	
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

