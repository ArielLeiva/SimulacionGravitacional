extends RigidBody2D

@onready var col = $CollisionShape2D
@onready var sprite = $Sprite2D
var camera = Camera2D

var proportion = 1

func is_inside_ball(p: Vector2):
	return (p-position).length_squared() <= (proportion * glob.base_ball_col_size)**2

func _ready():
	col.shape = CircleShape2D.new()
	col.position.x = 2
	col.position.y = 2
	col.shape.radius = proportion * glob.base_ball_col_size
	sprite.scale = Vector2(proportion, proportion)
	sprite.texture = glob.new_sprite
	# Picking some random skin for the next ball
	glob.set_random_sprite()	
	camera = get_tree().get_first_node_in_group("camera")
	
	
	
func _unhandled_input(event):
	#TODO: Support mobile ball deleting
	if event.is_pressed() and ((event is InputEventMouseButton and event.is_action("r_click"))):
		if is_inside_ball(camera.camera_to_global(event.position)):
			queue_free()

func _physics_process(_delta):
	if glob.attract:
		var rsqr = 0
		for x in get_tree().get_nodes_in_group("balls"):
			rsqr = x.position.distance_squared_to(position)
			if rsqr != 0:
				x.apply_central_impulse(1000 * mass * x.position.direction_to(position) / rsqr)
