extends Control


func _on_button_play_pressed():
	get_tree().change_scene("res://scenes/level.tscn")


func _on_button_how_to_play_pressed():
	get_tree().change_scene("res://scenes/gui/how_to_play.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
