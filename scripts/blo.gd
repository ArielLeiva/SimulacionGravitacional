extends Node2D

var vel = Vector2.ZERO
@export var mass: float = 2000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Uncomment this to make balls follow the mouse
	#var cursor = get_viewport().get_mouse_position()
	#var rsqr = position.distance_to(cursor)
	#if rsqr != 0:
	#	vel += 3000*delta * position.direction_to(cursor) / rsqr
	
	if glob.attract:
		var rsqr = 0
		for x in glob.blos:
			rsqr = position.distance_squared_to(x.position)
			if rsqr > 20:
				vel += x.mass * delta * position.direction_to(x.position) / rsqr
		position += delta * vel
