extends "res://Project/Script/TemplateCharacter.gd"

const fov_tolerance = 20
const red = Color(1,0.25,0.25)
const white = Color(1,1,1)

var max_detection_range = 560
var distance_to_player
var npc_facing_direction 
var direction_to_player
var player_in_range
var player

func _ready():
	player = get_node("/root").find_node("Player", true, false)

func _process(delta):
	player_in_fow()

func player_in_fow():
	if check_player_in_range() and check_player_in_los():
		get_tree().call_group("SuspicionMeter", "player_seen")
		$Torch.color = red
	else:
		$Torch.color = white

func check_player_in_range():
	check_npc_direction_to_player()
	if abs(direction_to_player.angle_to(npc_facing_direction)) < deg2rad(fov_tolerance):
		return true
		
	return false

func check_npc_direction_to_player():
	npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	direction_to_player = (player.position - global_position).normalized()

func check_player_in_los():
	var los_obstacle = set_los_obstacle()
	get_player_distance()
	
	if check_player_conditions(los_obstacle):
		return true

func check_player_conditions(los_obstacle):
	if los_obstacle and los_obstacle.collider == player and player_in_range:
		return true

func get_player_distance():
	var distance_to_player = player.global_position.distance_to(global_position)
	player_in_range = distance_to_player < max_detection_range

func set_los_obstacle():
	var space = get_world_2d().direct_space_state
	return space.intersect_ray(global_position, player.global_position,[self], collision_mask)
