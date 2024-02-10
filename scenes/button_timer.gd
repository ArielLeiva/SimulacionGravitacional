extends Timer

var button_id: int = -1
@onready var st = get_parent()

func change(id):
	match id:
		0:
			glob.new_mass += 100
		1:
			glob.new_mass -= 100
		2:
			glob.new_vol += 0.1
		3:
			glob.new_vol -= 0.1

func _ready():
	change(button_id)	

func _on_timeout():
	print("HOLAA")
	
	change(button_id)
			
	if !st.conds[button_id]:
		print("Destruido")
		queue_free()
