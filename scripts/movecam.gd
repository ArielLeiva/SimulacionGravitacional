extends Camera2D

@export var speed: float = 500
var drag_held: bool = false

var min_zoom = Vector2(0.2,0.2)
var max_zoom = Vector2(2,2)
var des_zoom = Vector2(0.5,0.5)
var zoom_speed = 0.1
# Used for camera drag
var old_offset = Vector2.ZERO
var old_mouse = Vector2.ZERO


func camera_to_global(coordinate):
	return coordinate * (1/zoom.x) - Vector2(-640*(1-1/zoom.x),-360*(1-1/zoom.x)) + offset

func _process(delta):
	var des_offset = offset
	des_zoom = clamp(des_zoom, min_zoom, max_zoom)
	zoom = lerp(zoom, des_zoom, 0.1)
	
	var vel = Vector2(0,0)
	if Input.is_action_pressed("camera_up"):
		vel.y -= 1
	if Input.is_action_pressed("camera_down"):
		vel.y += 1
	if Input.is_action_pressed("camera_left"):
		vel.x -= 1
	if Input.is_action_pressed("camera_right"):
		vel.x += 1
	
	if (!drag_held and Input.is_action_pressed("drag_camera")):
		drag_held = true
		old_offset = offset
		old_mouse = (get_viewport().get_mouse_position())
	elif drag_held:
		des_offset = old_offset + (1/zoom.x)*(old_mouse - get_viewport().get_mouse_position())
		if Input.is_action_just_released("drag_camera"):
			drag_held = false
		
	vel = vel.normalized()
	
	des_offset += delta * speed *vel
	offset = des_offset.clamp(Vector2(-1920, -1080), Vector2(1920, 1080))
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if (event.button_index == MOUSE_BUTTON_WHEEL_UP):
				if(des_zoom < max_zoom):
					des_zoom += Vector2(zoom_speed, zoom_speed)
			if (event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
				if (des_zoom > min_zoom):
					des_zoom -= Vector2(zoom_speed, zoom_speed)
