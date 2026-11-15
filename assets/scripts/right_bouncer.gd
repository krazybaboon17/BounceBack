extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.x = -400.0 
		body.velocity.y = -500.0 
		if body.has_method("trigger_wall_bounce"):
			body.trigger_wall_bounce()
