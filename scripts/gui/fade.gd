extends Panel

onready var animation_player = $animation_player


func _ready():
	fade_in()


func fade_in():
	animation_player.play("fade_in")


func fade_out():
	animation_player.play("fade_out")


func fade_out_in():
	animation_player.play("fade_out_in")
