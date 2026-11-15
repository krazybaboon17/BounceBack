extends Node2D
var leftBouncer = preload("res://assets/scenes/left_bouncer.tscn")
var rightBouncer = preload("res://assets/scenes/right_bouncer.tscn")
var leftSlime = preload("res://assets/scenes/slime_left.tscn")
var rightSlime = preload("res://assets/scenes/slime_right.tscn")
var leftBlank = preload("res://blank_left.tscn")
var rightBlank = preload("res://blank_right.tscn")
@export var groundNode: PackedScene
var baseGround = preload("res://assets/scenes/base_ground.tscn")
var rightGroundNode = preload("res://right_ground.tscn")
var left_bouncer

var score = 0
@onready var canvas_layer = $CanvasLayer


var left_slime
var right_blank
var left_blank
var right_bouncer
var right_slime
var left_ground
var right_ground
var base_ground
var tileOptions = ["Bounce", "Slime", "Ground"]
var tiles = ["BaseGround", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce"]
var rTiles = ["BaseGround", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce", "Bounce"]
#var tiles = ["BaseGround", "Slime", "Slime","Slime","Slime","Slime","Slime","Slime"]
#var rTiles = ["BaseGround", "Slime", "Slime","Slime","Slime","Slime","Slime","Slime"]
var thing = true
#Array with the order of all the tiles
#Every n seconds, the first element is popped, to replace with a new, randomly generated one at the top
#Add weights to the randomness
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canvas_layer.updateScore(str(0))
	
	drawLeft()
	drawRight()
	randomize()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	canvas_layer.updateScore(str(score))
	if (Input.is_action_pressed("space") and thing):
		$Timer.start()
		$ScoreTimer.start()
		thing = false
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
			left_slime.add_to_group("slimes")
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
		
		if (rTiles[i] == "Bounce"):
			right_bouncer = rightBouncer.instantiate()
			right_bouncer.position = Vector2(1, 672 - (i * 96))
			right_bouncer.add_to_group("walls")
			add_child(right_bouncer)
			
		if (rTiles[i] == "Slime"):
			right_slime = rightSlime.instantiate()
			right_slime.position = Vector2(1, 672 - (i * 96))
			right_slime.add_to_group("walls")
			right_slime.add_to_group("slimes")
			add_child(right_slime)
		if (rTiles[i] == "Ground"):
			right_ground = rightGroundNode.instantiate()
			right_ground.position = Vector2(1, 672 - ((i + 1) * 96))
			right_ground.add_to_group("walls")
			add_child(right_ground)
		if (tiles[i] == "BaseGround"):
			base_ground = baseGround.instantiate()
			base_ground.position = Vector2(10, 672 - (i * 96))
			base_ground.add_to_group("walls")
			add_child(base_ground)
			
		


func _on_timer_timeout() -> void:
	var numL = randf_range(0, 100)
	var tileL
	if (numL < 60):
		tileL = "Bounce"
	elif (numL < 90):
		tileL = "Slime"
	else:
		tileL = "Ground"
		
	if tileL == "Ground" and tiles.back() == "Ground":
		tileL = "Bounce"
		
	tiles.remove_at(0)
	tiles.append(tileL)
	
	var numR = randf_range(0, 100)
	var tileR
	if (numR < 60):
		tileR = "Bounce"
	elif (numR < 90):
		tileR = "Slime"
	else:
		tileR = "Ground"
		
	if tileR == "Ground" and rTiles.back() == "Ground":
		tileR = "Bounce"
		
	rTiles.remove_at(0)
	rTiles.append(tileR)
	
	for i in get_tree().get_nodes_in_group("walls"):
		i.queue_free()
		
	drawRight()
	drawLeft()


func _on_score_timer_timeout() -> void:
	score += 1
