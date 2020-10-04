extends Node2D

export(NodePath) var target_path

onready var target


# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(target_path)


func _physics_process(delta):
	if target:
		global_position = target.global_position
