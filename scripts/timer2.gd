extends Timer

var blo = preload("res://scenes/blo.tscn")

func _on_timeout():
	var st = get_node("../stage")
	if st.spawn:
		var p = blo.instantiate()
		p.position = get_viewport().get_mouse_position()
		add_child(p)
		glob.blos.append(p)
