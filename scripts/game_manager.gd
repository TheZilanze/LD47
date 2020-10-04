extends Node2D

onready var player = $player

var enemies = []


# Called when the node enters the scene tree for the first time.
func _ready():
	# Player
	player.connect("dead", self, "on_player_dead")
	
	# Enemies
	for node in get_tree().get_nodes_in_group("enemy"):
		enemies.append(node)
	
	# Teleport
	for node in get_tree().get_nodes_in_group("teleport"):
		node.connect("teleport", self, "on_teleport")


func reset_player():
	player.reset()


func reset_enemies():
	for enemy in enemies:
		enemy.reset()


func on_teleport():
	reset_enemies()


func on_player_dead():
	yield(get_tree().create_timer(1.0), "timeout")
	#...
	reset_player()
	reset_enemies()
