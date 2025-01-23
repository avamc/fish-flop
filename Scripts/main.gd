extends Node2D
@export var playerScene:PackedScene
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = playerScene.instantiate()
	player.position = $PlayerSpawnpoint.position
	add_child(player)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
