extends Area2D

func _on_body_exited(body):
	print("DIE")
	body.queue_free()
