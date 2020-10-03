extends Area2D

var wait_fixed_frames = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_entered")


func _physics_process(delta):
	if wait_fixed_frames <= 0:
		wait_fixed_frames -= 1
		return
	queue_free()


func on_body_entered(body):
	if body.is_in_group("enemy"):
		body.assign_point_of_interest(global_position)
