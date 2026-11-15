extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.x = -1350.0 
		body.velocity.y = -600.0 
		if body.has_method("trigger_wall_bounce"):
			#body.position.x -= 50
			body.trigger_wall_bounce()
