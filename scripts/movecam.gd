extends Camera2D

@onready var container = get_tree().get_first_node_in_group("container")
@export var speed: float = 500
var drag_held: bool = false
var cont_width = 0
var cont_height = 0
var cont_limit = Vector2.ZERO
var camera_limit = Vector2(1280,720)

@export var limited_camera: bool = true
var min_zoom = Vector2(0.17,0.17)
var max_zoom = Vector2(2,2)
var des_zoom = Vector2(0.5,0.5)
var zoom_speed = 0.1
# Used for camera drag
var old_offset = Vector2.ZERO
var old_mouse = Vector2.ZERO

func _ready():
	cont_width = container.shape.size.x
	cont_height = container.shape.size.y
	
func inside_camera(coord):
	return coord < camera_limit and coord >= Vector2.ZERO

func inside_container(coord):
	var cont_border = container.shape.size / 2
	return (coord < cont_border and coord >= -cont_border) or !limited_camera

func camera_to_global(coordinate):
	return coordinate * (1/zoom.x) - Vector2(1280/(2*zoom.x),720/(2*zoom.y)) + offset

func _process(delta):
	var des_offset = offset
	des_zoom = clamp(des_zoom, min_zoom, max_zoom)
	zoom = lerp(zoom, des_zoom, 0.1)
	get_tree().get_first_node_in_group("previsualization").update_scale()
	cont_limit = Vector2((cont_width-1280/zoom.x)/2, (cont_height - 720/zoom.y)/2)
	
	# Camera keyboard moving
	var vel = Vector2(0,0)
	if Input.is_action_pressed("camera_up"):
		vel.y -= 1
	if Input.is_action_pressed("camera_down"):
		vel.y += 1
	if Input.is_action_pressed("camera_left"):
		vel.x -= 1
	if Input.is_action_pressed("camera_right"):
		vel.x += 1
	
	# Camera dragging movement
	if !drag_held and (Input.is_action_pressed("drag_camera") or (Input.is_action_pressed("l_click") and glob.mode == glob.states.DRAG_MODE)):
		drag_held = true
		old_offset = offset
		old_mouse = (get_viewport().get_mouse_position())
	elif drag_held:
		des_offset = old_offset + (1/zoom.x)*(old_mouse - get_viewport().get_mouse_position())
		if Input.is_action_just_released("drag_camera") or (Input.is_action_just_released("l_click") and glob.mode == glob.states.DRAG_MODE):
			drag_held = false
		
	vel = vel.normalized()
	
	des_offset += delta * speed *vel
	if limited_camera:
		offset = des_offset.clamp(-cont_limit, cont_limit)
	else:
		offset = des_offset
	
func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		if des_zoom < max_zoom:
			des_zoom += Vector2(zoom_speed, zoom_speed)
	if event.is_action_pressed("zoom_out"):
		if des_zoom > min_zoom:
			des_zoom -= Vector2(zoom_speed, zoom_speed)
