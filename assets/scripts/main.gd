extends Node2D
@export var leftBouncer: PackedScene
@export var leftSlime: PackedScene
@export var rightBouncer: PackedScene
@export var rightSlime: PackedScene
@export var groundNode: PackedScene
var baseGround = preload("res://assets/scenes/base_ground.tscn")
var left_bouncer
var left_slime
var right_bouncer
var right_slime
var left_ground
var right_ground
var base_ground
var tileOptions = ["Bounce", "Slime", "Ground"]
var tiles = ["BaseGround", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce"]
#Array with the order of all the tiles
#Every n seconds, the first element is popped, to replace with a new, randomly generated one at the top
#Add weights to the randomness
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	drawLeft()
	drawRight()
	randomize()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func drawLeft():
	for i in 8:
		
		if (tiles[i] == "Bounce"):
			left_bouncer = leftBouncer.instantiate()
			left_bouncer.position = Vector2(1, 672 - (i * 96))
			left_bouncer.add_to_group("walls")
			add_child(left_bouncer)
			
		if (tiles[i] == "Slime"):
			left_slime = leftSlime.instantiate()
			left_slime.position = Vector2(1, 672 - (i * 96))
			left_slime.add_to_group("walls")
			add_child(left_slime)
		if (tiles[i] == "Ground"):
			left_ground = groundNode.instantiate()
			left_ground.position = Vector2(1, 672 - (i * 96))
			left_ground.add_to_group("walls")
			add_child(left_ground)
		if (tiles[i] == "BaseGround"):
			base_ground = baseGround.instantiate()
			base_ground.position = Vector2(10, 672 - (i * 96))
			base_ground.add_to_group("walls")
			add_child(base_ground)
			
func drawRight():
	for i in 8:
		
		if (tiles[i] == "Bounce"):
			right_bouncer = rightBouncer.instantiate()
			right_bouncer.position = Vector2(1, 672 - (i * 96))
			right_bouncer.add_to_group("walls")
			add_child(right_bouncer)
			
		if (tiles[i] == "Slime"):
			right_slime = rightSlime.instantiate()
			right_slime.position = Vector2(1, 672 - (i * 96))
			right_slime.add_to_group("walls")
			add_child(right_slime)
		if (tiles[i] == "Ground"):
			right_ground = groundNode.instantiate()
			right_ground.position = Vector2(1, 672 - (i * 96))
			right_ground.add_to_group("walls")
			add_child(right_ground)
		


func _on_timer_timeout() -> void:
	var num = randf_range(0, 100)
	var tile
	if (num < 60):
		tile = tileOptions[0]
	elif (num < 90):
		tile = tileOptions[1]
	else:
		tile = tileOptions[2]
	tiles.remove_at(0)
	tiles.append(tile)
	
	for i in get_tree().get_nodes_in_group("walls"):
		i.queue_free()
	drawRight()
	drawLeft()
	
	
	
	
		
		
	
