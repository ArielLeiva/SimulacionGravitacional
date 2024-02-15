extends Area2D

@onready var area = $area
@onready var sprite = $area/sprite
var clicked_pos = Vector2.ZERO
var camera = null
@export var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	camera = get_tree().get_first_node_in_group("camera")
	set_process(false)
	set_physics_process(false)

func _input(event):
	if enabled and event.is_action_pressed("l_click"):
		clicked_pos = event.position
		if camera:
			clicked_pos = camera.camera_to_global(clicked_pos)
		area.position = clicked_pos
		visible = true
		set_process(true)
		set_physics_process(true)
	elif event.is_action_pressed("delete"):
		for ball in get_tree().get_nodes_in_group("selected"):
			ball.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("l_click"):
		var moved = clicked_pos - get_viewport().get_mouse_position()
		if camera:
			moved = clicked_pos - camera.camera_to_global(get_viewport().get_mouse_position())
		area.shape.size = moved.abs()
		sprite.scale = area.shape.size/120
		area.position = clicked_pos - moved/2

	elif Input.is_action_just_released("l_click"):
		visible = false
		set_process(false)
		set_physics_process(false)

func _on_body_entered(body):
	if enabled:
		body.add_to_group("selected")
