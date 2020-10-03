extends "res://scripts/actors/actor.gd"




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var input = Vector2(get_axis_strength("right", "left"), get_axis_strength("down", "up"))
	velocity = input.normalized() * speed


func get_axis_strength(positive, negative):
	return Input.get_action_strength(positive) - Input.get_action_strength(negative)
