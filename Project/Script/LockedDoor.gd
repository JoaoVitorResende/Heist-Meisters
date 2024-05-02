extends Area2D

var length = 4
var combination

func _ready():
	generate_combination()

func _on_door_body_entered(body):
	controll_numpad(false)

func _on_docked_door_body_exited(body):
	controll_numpad(true)

func controll_numpad(is_num_pad_open):
	if !is_num_pad_open:
		$CanvasLayer/NumpadCombination.popup_centered()
	elif is_num_pad_open:
		$CanvasLayer/NumpadCombination.hide()

func _on_numpad_combination_correct():
	$AnimationPlayer.play("Open")
	$CanvasLayer/NumpadCombination.hide()

func generate_combination():
	combination = CombinationGenerator.generate_combination(length)
	$CanvasLayer/NumpadCombination.combination = combination

func get_generated_combination():
	return combination
