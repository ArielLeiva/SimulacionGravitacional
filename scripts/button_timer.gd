extends Timer

var button_id: int = -1
@onready var st = get_parent()

func change(id):
	match id:
		0:
			glob.new_mass += 100
		1:
			if	(glob.new_mass > 100):
				glob.new_mass -= 100
		2:
			glob.new_vol += 0.1
		3:
			if (glob.new_vol > 0):
				glob.new_vol -= 0.1

func _ready():
	change(button_id)	
	pass

func _on_timeout():
	
	if !st.conds[button_id]:
		queue_free()
	else:
		change(button_id)
