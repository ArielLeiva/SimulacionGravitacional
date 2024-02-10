extends Timer

var blo = preload("res://scenes/blo.tscn")

func _on_timeout():
	randomize()
	var p = blo.instantiate()
	p.position = Vector2(randi_range(1,950), randi_range(1,540))
	add_child(p)
