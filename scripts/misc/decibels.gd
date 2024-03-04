extends HScrollBar

var music = null

func _ready():
	music = get_tree().get_first_node_in_group("music")

func _on_value_changed(bar_value):
	if bar_value != 0:
		music.volume_db = music.base_decibels + 5 * log(bar_value)
	else:
		music.volume_db = music.base_decibels
	
