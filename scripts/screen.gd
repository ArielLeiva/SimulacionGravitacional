extends CanvasLayer

@onready var mass_counter = $VBoxContainer/mass_counter

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func _on_line_edit_text_submitted(new_text):
	if int(new_text) != 0:
		glob.new_mass = int(new_text)	
	else:
		glob.new_mass = glob.min_mass
	mass_counter.text = str(glob.new_mass)
	mass_counter.visible = false
	mass_counter.visible = true
