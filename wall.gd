extends Area2D
class_name wall

@export var lowered_texture_path:String
#var lowered_texture = load("res://Art/wall-vertical-lowered.png")
var lowered_texture

func _ready():
	lowered_texture = load(lowered_texture_path)
	
func lower():
	print("wall lowering")
	$Sprite2D.texture = lowered_texture
	$CollisionShape2D.set_deferred("disabled", true)
