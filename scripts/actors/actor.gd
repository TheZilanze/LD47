extends KinematicBody2D

export(float) var speed = 128

var aiming = Vector2(1, 0) setget set_aiming
var velocity = Vector2()


# Set aiming
func set_aiming(value):
	if value.length_squared() <= 0.001:
		return
	aiming = value.normalized()
	look_at(to_global(aiming))


func _process(delta):
	update()


func _draw():
	#...
	draw_arc(Vector2.ZERO, 32, 0, PI * 2, 32, Color.green, 2.0, true)
	# Aiming
	draw_line(Vector2.ZERO, aiming * 32, Color.green, 2.0, true)


func _physics_process(delta):
	# Move
	velocity = move_and_slide(velocity)
