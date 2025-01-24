extends Node2D

var speed = 2
var direction:String
var player_in_bubble = false
var player
var player_reset_position
var kill_player = false
var water_tiles:TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	water_tiles = get_parent().get_node("%Water")
	
func spawn(_direction, dispenser_position):
	direction = _direction
	player_reset_position = dispenser_position + Vector2(8, 4)
	pass

#y+8, x+16
func _physics_process(delta):
	#make the bubble move in its set direction.
	if direction == "right":
		position.x += 8 * delta * speed
		position.y -= 4 * delta * speed
	if direction == "left":
		position.x -= 8 * delta * speed
		position.y += 4 * delta * speed
	if direction == "up":
		position.x -= 8 * delta * speed
		position.y -= 4 * delta * speed
	if direction == "down":
		position.x += 8 * delta * speed
		position.y += 4 * delta * speed
		
	if player_in_bubble:
		player.global_position = global_position
	
		if Input.is_action_just_pressed("pop_bubble"):
			pop()
			
	if water_tiles.get_cell_source_id(water_tiles.local_to_map(position)) != -1:
		pop()
		#complete level!

func pop():
	if player_in_bubble:
		player_in_bubble = false
		if kill_player:
			#Restart level
			player.global_position = player_reset_position
		else:
			player.global_position = player_reset_position

	#play animation
	#play sound
	queue_free()

func _on_bubble_area_area_entered(area):
	if area.is_in_group("bubble"):
		pop()
		area.get_parent().pop()

func _on_player_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		body.in_bubble = true
		player_in_bubble = true
	if body.is_in_group("collision_tile"):
		kill_player = true
		pop()
