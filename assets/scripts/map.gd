extends Node2D

@onready var clicks_counter = $Label
@onready var player = $CharacterBody2D

var clicks = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clicks_counter.text = "Clicks: " + str(clicks)
	if player.position.x > 3000:
		player.position.x = 216
		player.position.y = 117.9969
	# print(player.global_transform.origin)

func _on_button_pressed():
	clicks += 1
