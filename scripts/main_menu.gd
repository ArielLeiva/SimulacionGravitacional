extends Node2D

var bouncing: float = 0.0
var friction: float = 0.0
var disable_collision = false

func _on_b_slide_value_changed(value):
	bouncing = value / 100

func _on_f_slide_value_changed(value):
	friction = value / 100

func _on_collisions_disabled_toggled(toggled_on):
	disable_collision = toggled_on

func _unhandled_input(event):
	if event.is_action_pressed("start_game"):
		glob.ball_friction = friction
		glob.ball_bounce = bouncing
		glob.disable_collisions = disable_collision
		get_tree().change_scene_to_file("res://scenes/space.tscn")
		
