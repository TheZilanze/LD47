extends Node2D

const winning_kill_order = [
	"enemy-3",
	"enemy",
	"enemy-4",
	"enemy-2",
]

onready var player = $player

var enemies = []
var kill_order = []


# Called when the node enters the scene tree for the first time.
func _ready():
	# Player
	player.connect("dead", self, "on_player_dead")
	
	# Enemies
	for node in get_tree().get_nodes_in_group("enemy"):
		enemies.append(node)
		node.connect("dead", self, "on_enemy_dead", [node])
	
	# Teleport
	for node in get_tree().get_nodes_in_group("teleport"):
		node.connect("teleport", self, "on_teleport")


func reset_player():
	player.reset()


func reset_enemies():
	for enemy in enemies:
		enemy.reset()
	kill_order = []


func on_teleport():
	if kill_order.size() == winning_kill_order.size():
		if kill_order == winning_kill_order:
			print("Win!")
			# TODO: Enter win screen...
		else:
			print("Try again!")
			reset_enemies()


func on_player_dead():
	yield(get_tree().create_timer(1.0), "timeout")
	#...
	reset_player()
	reset_enemies()


func on_enemy_dead(enemy):
	print(enemy.name)
	kill_order.append(enemy.name)
	
