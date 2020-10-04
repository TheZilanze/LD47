extends "res://scripts/actors/actor.gd"

var initial_position


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = global_position


func _physics_process(delta):
	# Aim
	set_aiming(get_global_mouse_position() - global_position)
	
	# Fire
	if Input.is_action_just_pressed("fire"):
		fire()
	
	# Movement
	var input = Vector2(get_axis_strength("right", "left"), get_axis_strength("down", "up"))
	velocity = input.normalized() * speed


func get_axis_strength(positive, negative):
	return Input.get_action_strength(positive) - Input.get_action_strength(negative)


func reset():
	.reset()
	global_position = initial_position
