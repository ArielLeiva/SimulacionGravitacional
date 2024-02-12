extends RigidBody2D

@onready var col = $CollisionShape2D
@onready var sprite = $Sprite2D

var proportion = 1

func is_inside_ball(p: Vector2):
	return (p-position).length_squared() <= (proportion * glob.base_ball_col_size)**2

func _ready():
	col.shape = CircleShape2D.new()
	col.position.x = 2
	col.position.y = 2
	print(col.shape.radius)
	col.shape.radius = proportion * glob.base_ball_col_size
	sprite.scale = Vector2(proportion, proportion)
	
func _unhandled_input(event):
	#TODO: Support mobile ball deleting
	if event.is_pressed() and ((event is InputEventMouseButton and event.is_action("r_click"))):
		if is_inside_ball(event.position):
			print(get_parent())
			queue_free()

func _physics_process(delta):
	if glob.attract:
		var rsqr = 0
		for x in get_tree().get_nodes_in_group("balls"):
			rsqr = x.position.distance_squared_to(position)
			if rsqr != 0:
				x.apply_central_impulse(1000 * mass * x.position.direction_to(position) / rsqr)
