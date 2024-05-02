extends Node2D

export(NodePath) onready var locked_door = get_node(locked_door) as Node 
onready var combination_text = $CanvasLayer/ComputerPopup/NinePatchRect/CenterContainer/NinePatchRect/Label

func _ready():
	get_generated_combination()

func _on_area2D_body_entered(body):
	$CanvasLayer/ComputerPopup.popup_centered()

func _on_area2D_body_exited(body):
	$CanvasLayer/ComputerPopup.hide()

func get_generated_combination():
	combination_text.text = str(locked_door.get_generated_combination())
