extends CharacterBody2D

@export var speed: float = 400.0
@export var gravity: float = 1200.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_pressed("space"):
			velocity.y = -700

	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * delta * 15)

	var slimeFallSpeed = 50
	var isOnSlime = false
	var wallNormalX = 0.0
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var hitObject = collision.get_collider()
		
		if hitObject and hitObject.is_in_group("slimes"):
			isOnSlime = true
			# Get the direction the wall is facing
			wallNormalX = collision.get_normal().x
			
	if isOnSlime:
		velocity.y = slimeFallSpeed
		
		if direction == 0:
			# Apply a tiny micro-force against the wall's normal 
			# to keep the player completely stuck to it
			velocity.x = -wallNormalX * 10
			
	move_and_slide()
