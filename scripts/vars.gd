extends Node

var attract: bool = false
var new_mass: float = 200
var new_vol: float = 1
const base_ball_size = 60
# Best collision size obtained by trial and error
const base_ball_col_size = 59.5
const w_limit = 1280
const h_limit = 720
const limit = Vector2(w_limit, h_limit)
var sprites = []
var new_sprite = Texture2D

@onready var prev = get_tree().get_first_node_in_group("previsualization")

func load_sprites():
	var path = "res://assets/celestial_bodies/"
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var sprite = Texture2D
		while file_name != "":
			if file_name.ends_with(".png"):
				sprite = load(path + file_name)
				sprites.append(sprite)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Directory not found")

func set_random_sprite():
	if sprites:
		new_sprite = sprites[randi() % sprites.size()]
	else:
		print("No sprite found")
	prev.texture = new_sprite

func _ready():
	# Loading prites that will be used to create balls
	load_sprites()
	# Setting first sprite and updating previsualization
	set_random_sprite()
	
	pass
