extends CanvasGroup

func has_point(point):
	var has_it = false
	
	for rect in get_children():
		if rect.get_class() == "ReferenceRect":
			has_it = has_it or rect.get_rect().has_point(point)
	
	return has_it
