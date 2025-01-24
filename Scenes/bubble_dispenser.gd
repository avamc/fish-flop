extends StaticBody2D

@export var direction:String
@export var bubble_scene:PackedScene

var right_bubble_texture = load("res://Art/bubble-dispenser-right.png")
var left_bubble_texture = load("res://Art/bubble-dispenser-left.png")
var up_bubble_texture = load("res://Art/bubble-dispenser-up.png")
var down_bubble_texture = load("res://Art/bubble-dispenser-down.png")

var right_bubble_spawnpoint = Vector2(8, -4)
var left_bubble_spawnpoint = Vector2(-8, 4)
var up_bubble_spawnpoint = Vector2(-8, -4)
var down_bubble_spawnpoint = Vector2(8, 4)
# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == "right":
		$Sprite2D.set_texture(right_bubble_texture)
		$Sprite2D.z_index = 2
		$BubbleSpawnPoint.position = right_bubble_spawnpoint
	elif direction == "left":
		$Sprite2D.set_texture(left_bubble_texture)
		$Sprite2D.z_index = 1
		$BubbleSpawnPoint.position = left_bubble_spawnpoint
	elif direction == "up":
		$Sprite2D.set_texture(up_bubble_texture)
		$Sprite2D.z_index = 2
		$BubbleSpawnPoint.position = up_bubble_spawnpoint
	elif direction == "down":
		$Sprite2D.set_texture(down_bubble_texture)
		$Sprite2D.z_index = 1
		$BubbleSpawnPoint.position = down_bubble_spawnpoint
	else:
		print("You didn't set the bubble dispenser direction or misspelled it.")
	spawn_bubble()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_bubble_timer_timeout():
	#spawn a bubble!
	spawn_bubble()

func spawn_bubble():
	var bubble = bubble_scene.instantiate()
	add_child(bubble)
	bubble.position = $BubbleSpawnPoint.position
	bubble.spawn(direction, $BubbleSpawnPoint.global_position)
