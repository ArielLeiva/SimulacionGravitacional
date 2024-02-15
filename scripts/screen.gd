extends CanvasLayer

@onready var mass_counter = $VBoxContainer/mass_counter
@onready var modes_rect = $modes_rect
@onready var mass_vol_rect = $mass_vol_rect

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func inside_ui(point):
	return modes_rect.get_rect().has_point(point) or mass_vol_rect.get_rect().has_point(point)

func _on_line_edit_text_submitted(new_text):
	if int(new_text) != 0:
		glob.new_mass = int(new_text)	
	else:
		glob.new_mass = glob.min_mass
	mass_counter.text = str(glob.new_mass)
	mass_counter.visible = false
	mass_counter.visible = true
