extends KinematicBody2D

signal dead

const SOUND_AREA = preload("res://scenes/sound_area.tscn")

export(float) var speed = 128

onready var ray_cast_2d = $ray_cast_2d

var aiming = Vector2(1, 0) setget set_aiming
var velocity = Vector2(128, 0)
var is_alive = true


# Set aiming
func set_aiming(value):
	if value.length_squared() <= 0.001:
		return
	aiming = value.normalized()
	look_at(global_position + aiming)


func _process(delta):
	update()


func _draw():
	# Draws the actor
	draw_circle(Vector2.ZERO, 32, Color(0, 1, 0, 0.5) if is_alive else Color(1, 0, 0, 0.5))
	draw_arc(Vector2.ZERO, 32, 0, PI * 2, 32, Color.green if is_alive else Color.red, 2.0, true)
	# Draws where the actor is aiming
	draw_line(Vector2.ZERO, Vector2.RIGHT * 32, Color.green if is_alive else Color.red, 2.0, true)


func _physics_process(delta):
	# Only update if we are still alive
	if is_alive:
		# Move
		velocity = move_and_slide(velocity)


func fire():
	# Spawn sound area
	var sa = SOUND_AREA.instance()
	get_tree().root.add_child(sa)
	sa.position = global_position
	
	# Update the raycast
	ray_cast_2d.force_raycast_update()
	
	# Check if we hit something
	if ray_cast_2d.is_colliding():
		ray_cast_2d.get_collider().die()


func die():
	if is_alive:
		is_alive = false
		emit_signal("dead")
