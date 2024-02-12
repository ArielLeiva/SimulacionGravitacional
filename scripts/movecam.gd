extends Camera2D

@onready var txt = $TextEdit
@onready var prev = $prev
@export var speed: float

func _process(delta):
	position.x += speed
	txt.text = str(glob.new_mass)
	prev.scale = Vector2(glob.new_vol, glob.new_vol)
