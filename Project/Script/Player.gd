extends "res://Project/Script/TemplateCharacter.gd"

var motion = Vector2()
var is_disquised = false

const player_sprite = "res://Project/Art/GFX/PNG/Hitman 1/hitman1_stand.png"

const box_sprite = "res://Project/Art/GFX/PNG/Tiles/tile_129.png"

const equipament_sound = "res://Project/Art/SFX/equipaudio.mp3"

func _physics_process(delta):
	if !is_disquised:
		update_movement()
		
	update_rotation()
	move_and_slide(motion)

func update_rotation():
	look_at(get_global_mouse_position())

func update_movement():
	if check_up_and_down():
		motion.y = calculate_movement(motion.y,"positive")
	elif check_down_and_up():
		motion.y = calculate_movement(motion.y,"negative")
	elif check_left_and_right():
		motion.x = calculate_movement(motion.x,"negative")
	elif check_right_and_left():
		motion.x = calculate_movement(motion.x,"positive")
	else:
		stop_movement()

func stop_movement():
	motion.y = lerp(motion.y, 0, friction)
	motion.x = lerp(motion.x, 0, friction)

func calculate_movement(direction, type):
	if(type == "positive"):
		return clamp(direction + speed, 0, max_speed)
	else:
		return clamp(direction - speed, -max_speed, 0)

func check_up_and_down():
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		return true

func check_down_and_up():
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		return true

func check_right_and_left():
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		return true

func check_left_and_right():
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		return true

func _input(event):
	check_night_vision_input()
	check_box_equipament_intput()

func check_box_equipament_intput():
	if Input.is_action_just_pressed("box_equiped"):
		stop_movement()
		make_sound(equipament_sound)
		toogle_disguese()

func toogle_disguese():
	if is_disquised:
		is_disquised = false
		collision_layer = 1
		$Sprite.texture = load(player_sprite)
		return
		
	is_disquised = true
	collision_layer = 16
	$Sprite.texture = load(box_sprite)

func check_night_vision_input():
	if Input.is_action_just_pressed("night_vision"):
		get_tree().call_group("Interface", "cycle_vision_mode")

func make_sound(sound):
	$AudioStreamPlayer.stream = load(sound)
	$AudioStreamPlayer.play()

func collect_briefcase():
	var loot = Node.new()
	loot.set_name("Briefcase")
	add_child(loot)
	get_tree().call_group("Loot","collect_loot")
