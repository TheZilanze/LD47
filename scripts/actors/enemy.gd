extends "res://scripts/actors/actor.gd"

export(float, 0, 360) var fov = 180

var player = null
var move_to = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]


func _physics_process(delta):
	if is_alive:
		# See player, fire at player
		if player.is_alive and in_line_of_sight(player):
			# Update move to
			assign_point_of_interest(player.global_position)
			# Signal where you the player has been seen
			#...
			# Update aim
			set_aiming(player.global_position - global_position)
			# Fire
			#fire()
		else:
			set_aiming(velocity)
		
		
		
		
		
		# Move towards 'move_to'
		velocity = seek(move_to)


func seek(target_pos):
	return global_position.direction_to(target_pos) * speed


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


func assign_point_of_interest(point_of_interest):
	move_to = point_of_interest
