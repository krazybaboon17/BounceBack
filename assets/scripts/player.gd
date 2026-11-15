extends CharacterBody2D
@export var speed: float = 400.0
@export var gravity: float = 1200.0

func _physics_process(delta: float) -> void:
	# 1. Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0 # Reset vertical velocity when landing on the ground

	# 2. Basic left and right movement
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta * 15)

	# 3. Move and handle collisions with the ground
	move_and_slide()
	
