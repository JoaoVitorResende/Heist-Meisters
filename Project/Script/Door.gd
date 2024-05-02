extends Area2D

var is_open = false

func _on_door_body_entered(body):
	$AnimationPlayer.play("Open")
		
