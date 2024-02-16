extends Node2D

@onready var sprite = $sprite
@export var tickness = 100
const init_length:float = 720

func _ready():
	visible = true

func look_and_scale(vector: Vector2):
	rotation = vector.angle()
	scale = Vector2(vector.length()/init_length, vector.length()/init_length)
	sprite.scale.y = tickness/vector.length()

