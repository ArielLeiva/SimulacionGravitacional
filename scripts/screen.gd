extends CanvasLayer

@onready var mass_counter = $VBoxContainer/mass_counter
@onready var modes_rect = $modes_rect
@onready var mass_vol_rect = $mass_vol_rect
@onready var follow_button = $VBoxContainer/CanvasGroup/follow 

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func inside_ui(point):
	return modes_rect.get_rect().has_point(point) or mass_vol_rect.get_rect().has_point(point)

func _on_line_edit_text_submitted(new_text):
	if int(new_text) != 0:
		glob.new_mass = clamp(int(new_text), glob.min_mass, glob.max_mass)
	else:
		glob.new_mass = glob.min_mass
	mass_counter.text = str(glob.new_mass)
	mass_counter.visible = false
	mass_counter.visible = true

func update_ui():
	follow_button.visible = !get_tree().get_nodes_in_group("selected").is_empty()

func _on_selection_selection_released():
	follow_button.visible = true

func _on_selection_selection_clean():
	follow_button.visible = false
