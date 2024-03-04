extends Node

var attract: bool = false
var new_mass: float = 100
@export var max_mass: float = 2**20
@export var min_mass: float = 100

var new_vol: float = 1
@export var min_vol: float = 0.12
@export var max_vol: float = 5

const base_ball_size = 60
# Best collision size obtained by trial and error
const base_ball_col_size = 59.5
const w_limit = 1280
const h_limit = 720
const limit = Vector2(w_limit, h_limit)
var sprites = []
var new_sprite = Texture2D

enum states { SPAWN_MODE, SELECT_MODE , DRAG_MODE}
var mode = states.SPAWN_MODE

var ball_friction = 0
var ball_bounce = 0
var disable_collisions = false

func load_sprites():
	var path = "res://assets/celestial_bodies/"
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var sprite = Texture2D
		while file_name != "":
			print(file_name)
			if file_name.ends_with(".png.import"):
				sprite = load(path + file_name.trim_suffix(".import"))
				sprites.append(sprite)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Directory not found")

func set_random_sprite():
	var prev = get_tree().get_first_node_in_group("previsualization")
	if sprites.size() != 0:
		new_sprite = sprites[randi() % sprites.size()]
		if prev:
			prev.texture = new_sprite
		else:
			print("Warning: No previsualization setted")
	else:
		print("No sprite found")

func default():
	new_mass = 100
	new_vol = 1
	attract = false
	get_tree().paused = false
	Engine.time_scale = 1
	
	# Loading prites that will be used to create balls
	load_sprites()
	# Setting first sprite and updating previsualization
	set_random_sprite()
	# Setting initial mode
	glob.mode = states.SPAWN_MODE

func _ready():
	default()
	
