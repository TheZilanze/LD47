extends "res://scripts/actors/actor.gd"

export(float, 0, 360) var fov = 180

var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	print(player.name)


func _physics_process(delta):
	if is_alive:
		# See player, fire at player
		if player.is_alive and in_line_of_sight(player):
			# Update aim
			set_aiming(player.global_position - global_position)
			# Fire
			fire()
			# Update move to
			#...
			# Signal where you the player has been seen
			#...
		
		#...
		
		


#...
func in_line_of_sight(target):
	var to_target = global_position.direction_to(target.global_position)
	
	var angle = aiming.angle_to(to_target)
	if abs(rad2deg(angle)) > fov * 0.5:
		return
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, global_position + to_target * 5000, [self])
	
	if result:
		return result['collider'] == target
	
	return false
