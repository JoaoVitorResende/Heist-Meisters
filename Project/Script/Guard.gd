extends "res://Project/Script/PlayerDetection.gd"

export var minimum_arrival_distance = 3
export var walk_speed = 0.5
export(NodePath) onready var available_destinations = get_node(available_destinations) as Node
onready var navigation_map = get_tree().get_root().find_node("Navigation2D", true, false)

var motion
var possible_destinations
var path: PoolVector2Array

func _init():
	set_guard_max_detection_range()

func set_guard_max_detection_range():
	max_detection_range = 270

func _ready():
	randomize()
	make_path()

func make_path():
	get_destinations()
	var new_destination = possible_destinations[randi() % possible_destinations.size() -1]
	path.append_array(navigation_map.get_simple_path(position, new_destination.position, false)) 

func get_destinations():
	possible_destinations = available_destinations.get_children()

func _physics_process(delta):
	navigate()

func navigate():
	var distance_to_destination = position.distance_to(path[0])
	
	if distance_to_destination > minimum_arrival_distance :
		move_guard()
		turn_guard_to()
	else :
		update_path()

func move_guard():
	motion = (path[0] - position).normalized() * (max_speed * walk_speed)
	if is_on_wall():
		path.remove(0)
		make_path()
		
	move_and_slide(motion)

func turn_guard_to():
	look_at(path[0])

func update_path():
	if path.size() == 1:
		make_path()
	else:
		path.remove(0)
