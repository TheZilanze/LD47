extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if visible:
			hide()
		else:
			show()
		get_tree().paused = !get_tree().paused


func _notification(what):
	match what:
		NOTIFICATION_WM_FOCUS_OUT:
			show()
			get_tree().paused = true


func _on_button_resume_pressed():
	hide()
	get_tree().paused = false


func _on_button_back_to_menu_pressed():
	get_tree().change_scene("res://scenes/gui/main_menu.tscn")
