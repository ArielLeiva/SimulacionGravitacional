extends TouchScreenButton

@onready var texture_idle = texture_normal
var active: bool = true

func _ready():
	set_texture()

func set_texture():
	if active:
		texture_normal = texture_pressed
	else:
		texture_normal = texture_idle

func _on_modes_mode_changed():
	active = glob.mode == glob.states.SPAWN_MODE
	set_texture()
