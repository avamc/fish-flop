extends CharacterBody2D

@export var hspeed = 150 #horizontal speed
@export var vspeed = 150 #vertical speed
@export var dashspeed = 300 #dash speed

var accel_t = 0.0 #acceleration time
var decel_t = 0.0 #deceleration time
var accel_friction = 16
var decel_friction = 0.9 #speed of deceleration

var breath = 6
var player_dead = false

var target_velocity = Vector2.ZERO #target velocity
var input = Vector2.ZERO #input

var debug = false

signal lost_air
signal dead

func _ready():
	pass
	#$Area2D/CollisionShape2D.disabled = false
	#$AnimatedSprite2D.animation = "default" #initially set animation to default

func get_input():
	if Input.is_action_just_released("move_right"):
		position.y  -= 8
		position.x += 16
		lose_air()
		
	if Input.is_action_just_released("move_left"):
		position.y += 8
		position.x -= 16
		lose_air()
		
	if Input.is_action_just_released("move_up"):
		position.y -=8
		position.x -= 16
		lose_air()
	
	if Input.is_action_just_released("move_down"):
		position.y += 8
		position.x += 16
		lose_air()


	#DEBUG
	if Input.is_action_just_pressed("debug"):
		debug = !debug
		if debug:
			$CollisionShape2D.disabled = true
		else:
			$CollisionShape2D.disabled = false

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
