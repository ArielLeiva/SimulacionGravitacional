extends Node

@onready var st = get_node("../stage")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if st.add_mass:
		glob.new_mass += 100
		st.add_mass = false
	if st.sub_mass:
		glob.new_mass -= 100
		st.sub_mass = false
	if st.add_vol:
		glob.new_vol += 0.1
		st.add_vol = false
	if st.sub_vol:
		glob.new_vol -= 0.1
		st.sub_vol = false
