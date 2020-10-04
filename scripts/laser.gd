extends Line2D

onready var animation_player = $animation_player


# Called when the node enters the scene tree for the first time.
func _ready():
	init(Vector2(100, 100), Vector2(500, 500))
func init(from, to):
	points = [from, to]
	# Animation
	animation_player.play("fade")
	yield(animation_player, "animation_finished")
	queue_free()
