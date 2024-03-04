extends CanvasGroup

signal mode_changed

func _unhandled_input(event):
	if event.is_action_pressed("drag_mode") or event.is_action_pressed("select_mode") or event.is_action_pressed("spawn_mode"):
		emit_signal("mode_changed")
