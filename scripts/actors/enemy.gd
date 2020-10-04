extends "res://scripts/actors/actor.gd"

export(float, 0, 360) var fov = 180

var player = null
var path = []

var nav_mesh

# Patrol
var patrol = []
var patrol_index = 1
var is_patrolling = true


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	
	nav_mesh = get_tree().get_nodes_in_group("nav_mesh")[0]
	
	# Patrol
	# Retrieve the patrol positions
	for child in get_node("patrol").get_children():
		if child is Position2D:
			patrol.append(child.global_position)
	
	# Move the player to the first patrol point (if one exists)
	if not patrol.empty():
		global_position = patrol[0]
		
		# Add the next patrol position to the path (if one exits)
		if patrol.size() > patrol_index:
			path = get_nav_path(patrol[patrol_index])


func _draw():
	for i in path.size():
		var start = Vector2() if i == 0 else to_local(path[i - 1])
		var end = to_local(path[i])
		draw_line(start, end, Color.blue, 2.0, true)


func _physics_process(delta):
	# See player, fire at player
	if player.is_alive and in_line_of_sight(player):
		# Update move to
		assign_point_of_interest(player.global_position)
		# Signal where you the player has been seen
		#...
		# Update aim
		set_aiming(player.global_position - global_position)
		# Fire
		fire()
	else:
		set_aiming(velocity)
	
	# If no path exists
	if path.empty():
		velocity = Vector2()
		return
	
	# Remove position from path if we are close enough to consider it reached
	if global_position.distance_to(path[0]) < speed * delta:
		# Remove the reached position
		path.remove(0)
		# If patrolling start moving to the next patrol position
		if is_patrolling:
			patrol_index = (patrol_index + 1) % patrol.size()
			path = get_nav_path(patrol[patrol_index])
		# If not patrolling and the end of the path has been reached, return to patrolling
		elif path.empty():
			is_patrolling = true
			path = get_nav_path(patrol[patrol_index])
	
	velocity = seek(path[0])


# Returns a path from the actors position to a 'target_position'
func get_nav_path(target_position):
	var path = nav_mesh.get_simple_path(global_position, target_position, true)
	path.remove(0)
	return path


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
	is_patrolling = false
	path = get_nav_path(point_of_interest)


func reset():
	.reset()
	patrol_index = 1
	# Move the player to the first patrol point (if one exists)
	if not patrol.empty():
		global_position = patrol[0]
		# Add the next patrol position to the path (if one exits)
		if patrol.size() > patrol_index:
			path = get_nav_path(patrol[patrol_index])
