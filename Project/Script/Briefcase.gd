extends Area2D

func _on_briefcase_body_entered(body):
	body.collect_briefcase()
	queue_free()
