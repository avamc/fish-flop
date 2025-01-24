extends CharacterBody2D

@export var hspeed = 150 #horizontal speed
@export var vspeed = 150 #vertical speed
@export var dashspeed = 300 #dash speed
var grass_tiles:TileMapLayer
var water_tiles:TileMapLayer

var accel_t = 0.0 #acceleration time
var decel_t = 0.0 #deceleration time
var accel_friction = 16
var decel_friction = 0.9 #speed of deceleration

var breath = 6
var player_dead = false

var target_velocity = Vector2.ZERO #target velocity
var input = Vector2.ZERO #input

var debug = false
var in_bubble = false
var bubble_spawnpoint:Vector2
var spawn_position

var grass_tileset:TileMapLayer

var right_dir = Vector2(16, -8)
var left_dir = Vector2(-16, 8)
var up_dir = Vector2(-16, -8)
var down_dir = Vector2(16, 8)

signal lost_air
signal dead

func _ready():
	spawn_position = position
	grass_tiles = get_parent().get_node("%Grass")
	water_tiles = get_parent().get_node("%Water")

	#$Area2D/CollisionShape2D.disabled = false
	#$AnimatedSprite2D.animation = "default" #initially set animation to default

func get_input():
	#var tile_pos = grass_tiles.local_to_map(position)

	if not in_bubble:
		if Input.is_action_just_released("move_right"):
			calculate_movement(right_dir)
		if Input.is_action_just_released("move_left"):
			calculate_movement(left_dir)
		if Input.is_action_just_released("move_up"):
			calculate_movement(up_dir)
		if Input.is_action_just_released("move_down"):
			calculate_movement(down_dir)
	if in_bubble:
		if Input.is_action_just_pressed("pop_bubble"):
			in_bubble = false

	#DEBUG
	if Input.is_action_just_pressed("debug"):
		debug = !debug
		if debug:
			$CollisionShape2D.disabled = true
		else:
			$CollisionShape2D.disabled = false
			
func calculate_movement(direction):
	if grass_tiles.get_cell_source_id(grass_tiles.local_to_map(position + direction)) != -1:
		position += direction
		lose_air()
	elif water_tiles.get_cell_source_id(water_tiles.local_to_map(position + direction)) != -1:
		position += direction
		#complete level

func _physics_process(delta):
	if not player_dead:
		get_input()
		calc_movement()
	
func calc_movement():
	if input == Vector2.ZERO:
		#Idle animation
		pass
		
func lose_air():
	breath -= 1
	lost_air.emit()
