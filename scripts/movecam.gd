extends Camera2D

@onready var txt = $TextEdit
@onready var prev = $prev
@export var speed: float

var min = Vector2(0.2,0.2)
var max = Vector2(2,2)
var des_zoom = Vector2(1,1)
var zoom_speed = 0.1

func camera_to_global(coordinate):
	return coordinate * (1/zoom.x) - Vector2(-640*(1-1/zoom.x),-360*(1-1/zoom.x))

func _process(delta):
	position.x += speed
	des_zoom = clamp(des_zoom, min, max)
	zoom = lerp(zoom, des_zoom, 0.1)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if (event.button_index == MOUSE_BUTTON_WHEEL_UP):
				if(des_zoom < max):
					des_zoom += Vector2(zoom_speed, zoom_speed)
			if (event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
				if (des_zoom > min):
					des_zoom -= Vector2(zoom_speed, zoom_speed)
