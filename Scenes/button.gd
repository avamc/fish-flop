extends Area2D

@export var wall:Area2D

var pressed = false
signal button_pressed
var pressed_texture = load("res://Art/button-pressed.png")
var unpressed_texture = load("res://Art/button.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player") and not pressed:
		pressed = true
		button_pressed.emit()
		$Sprite2D.set_texture(pressed_texture)
		wall.lower()
