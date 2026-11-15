extends CharacterBody2D

@export var speed: float = 400.0
@export var gravity: float = 1200.0
@export var wall_bounce_speed: float = 450.0 
@export var wall_climb_force: float = -550.0    

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var left_boundary: float = -150.0
@export var right_boundary: float = 150.0

var is_bouncing: bool = false
var locked_direction: float = 0.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_pressed("space"):
			velocity.y = -700

	var direction := Input.get_axis("left", "right")
	
	if locked_direction != 0.0 and direction == locked_direction:
		direction = 0.0

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
			wallNormalX = collision.get_normal().x
			
	if isOnSlime:
		velocity.y = slimeFallSpeed
		
		if direction == 0:
			velocity.x = -wallNormalX * 10
			
	move_and_slide()
	
	global_position.x = clamp(global_position.x, left_boundary, right_boundary)


func trigger_wall_bounce() -> void:
	if is_bouncing:
		return
	
	$AudioStreamPlayer2D.play()
	is_bouncing = true
	anim.play("bounce")
	
	if global_position.x < 0.0:
		locked_direction = -1.0
	else:
		locked_direction = 1.0
	await get_tree().create_timer(0.25).timeout
	
	anim.play("default")
	is_bouncing = false
	locked_direction = 0.0
