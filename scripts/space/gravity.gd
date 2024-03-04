extends TouchScreenButton

@onready var texture_idle = texture_normal
var active: bool = false

func _on_pressed():
	if !active:
		texture_normal = texture_pressed
		active = true
	else:
		texture_normal = texture_idle
		active = false
