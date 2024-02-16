extends Node

# Time required (in seconds) to press ESC in order to close the game
var delay = 0.5
var elapsed_time = 0

func _ready():
	set_process(false)

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		elapsed_time = 0
		set_process(true)

func _process(delta):
	if Input.is_action_pressed("quit"):
		elapsed_time += delta
		if elapsed_time >= delay:
			get_tree().quit()
	elif Input.is_action_just_released("quit"):
		elapsed_time = 0
		set_process(false)
	
