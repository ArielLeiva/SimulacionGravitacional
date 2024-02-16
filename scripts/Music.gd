extends AudioStreamPlayer

@export var base_decibels: float = -15

func _ready():
	base_decibels = -15
	volume_db = base_decibels
	play()

func _on_finished():
	play()
