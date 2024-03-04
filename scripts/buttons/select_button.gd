extends TouchScreenButton

@onready var texture_idle = texture_normal
var active: bool = false

func set_texture():
	if active:
		texture_normal = texture_pressed
	else:
		texture_normal = texture_idle

func _on_modes_mode_changed():
	active = glob.mode == glob.states.SELECT_MODE
	set_texture()
