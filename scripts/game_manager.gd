extends Node2D

const winning_kill_order = [
	"enemy-3",
	"enemy",
	"enemy-4",
	"enemy-2",
]

export(NodePath) var fade_path

onready var player = $player
onready var fade = get_node(fade_path)

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
			fade.fade_out()
			yield(get_tree().create_timer(0.5), "timeout")
			get_tree().change_scene("res://scenes/gui/victory.tscn")
		else:
			reset_enemies()


func on_player_dead():
	#yield(get_tree().create_timer(0.25), "timeout")
	fade.fade_out_in()
	yield(get_tree().create_timer(0.5), "timeout")
	#...
	reset_enemies()
	reset_player()


func on_enemy_dead(enemy):
	kill_order.append(enemy.name)
