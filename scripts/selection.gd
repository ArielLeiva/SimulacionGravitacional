extends Area2D

signal selection_released
signal selection_clean

@onready var area = $area
@onready var sprite = $area/sprite
var clicked_pos = Vector2.ZERO
var camera = null
var ui = null
@export var enabled = true
var click_held = false

func deactivate():
	click_held = false
	visible = false
	set_process(false)
	set_physics_process(false)

# Called when the node enters the scene tree for the first time.
func _ready():
	enabled = false
	camera = get_tree().get_first_node_in_group("camera")
	ui = get_tree().get_first_node_in_group("UI")
	deactivate()

func _input(event):
	if enabled and event.is_action_pressed("l_click"):
		clicked_pos = event.position
		if !ui.inside_ui(clicked_pos):	
			if camera:
				clicked_pos = camera.camera_to_global(clicked_pos)
			area.position = clicked_pos
			click_held = true
			visible = true
			set_process(true)
			set_physics_process(true)
	elif event.is_action_pressed("delete"):
		for body in get_tree().get_nodes_in_group("selected"):
			if body.is_in_group("balls"):
				body.queue_free()
				
		selection_clean.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("r_click"):
		deactivate()	
	if Input.is_action_pressed("l_click"):
		var moved = clicked_pos - get_viewport().get_mouse_position()
		if camera:
			moved = clicked_pos - camera.camera_to_global(get_viewport().get_mouse_position())
		area.shape.size = moved.abs()
		sprite.scale = area.shape.size/120
		area.position = clicked_pos - moved/2
	elif Input.is_action_just_released("l_click"):
		if get_tree().get_nodes_in_group("selected"):
			selection_released.emit()
		deactivate()

func _on_body_entered(body):
	if enabled:
		body.add_to_group("selected")
		body.modulate = Color(0,0.4,0.4)

func _on_body_exited(body):
	# TODO: Build a better unselection
	if body.is_in_group("selected") and click_held:
		body.remove_from_group("selected")
		body.modulate = Color(1,1,1)
	pass

func _on_stage_mode_updated():
	enabled = glob.mode == glob.states.SELECT_MODE
