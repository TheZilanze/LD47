extends Area2D

onready var teleport_target = $node/teleport_target


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_entered")


func on_body_entered(body):
	# Teleport
	var to_body = body.global_position - global_position
	body.global_position = teleport_target.global_position + to_body
