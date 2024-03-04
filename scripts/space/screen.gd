extends CanvasLayer

@onready var mass_counter = $VBoxContainer/mass_counter
@onready var rects = $rects
@onready var follow_button = $VBoxContainer/modes/follow 
@onready var trash_can = $VBoxContainer/modes/trash_can
@onready var shrink_button = $VBoxContainer/modes/shrink

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size = DisplayServer.screen_get_size()

func inside_ui(point):
	return rects.has_point(point)

func _on_line_edit_text_submitted(new_text):
	if int(new_text) != 0:
		glob.new_mass = clamp(int(new_text), glob.min_mass, glob.max_mass)
	else:
		glob.new_mass = glob.min_mass
	mass_counter.text = str(glob.new_mass)
	mass_counter.visible = false
	mass_counter.visible = true

func update_ui():
	var are_selected_objs = !get_tree().get_nodes_in_group("selected").is_empty()
	follow_button.visible = are_selected_objs
	trash_can.visible = are_selected_objs
	shrink_button.visible = are_selected_objs

func _on_visibility_changed():
	if !visible:
		for body in get_tree().get_nodes_in_group("selected"):
			body.modulate = Color(1,1,1)
	else:
		for body in get_tree().get_nodes_in_group("selected"):
			body.modulate = Color(0.5,0.9,0.9)
