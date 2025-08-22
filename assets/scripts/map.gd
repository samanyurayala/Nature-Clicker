extends Node2D

@onready var clicks_counter = $CanvasLayer/Label
@onready var player = $CharacterBody2D

var clicks = 0
var clicker_helpers = 0
var clicker_price = 15
var clicks_multipliers = 0
var clicks_multiplier_price = 20
var speed_boosts = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clicks_counter.text = "Clicks: " + str(round(clicks))
	clicks += 0.0001 * clicker_helpers
	if player.position.x > 4000:
		player.position.x = 216
		player.position.y = 117.9969
	# print(clicker_helpers)
	# print(clicks_multipliers)
	# print(speed_boosts)

func _physics_process(delta):
	# Handle sprint. 
	if Input.is_action_pressed("Sprint"):
		player.speed = (50.0 + 0.1 * speed_boosts) * 2
	else:
		player.speed = 50.0 + 0.1 * speed_boosts
	
	if player.position.x >= 2972 and player.position.x <= 3120:
		if Input.is_action_just_pressed("Shop1") and clicks >= clicker_price:
			clicker_helpers += 1
			clicker_price += 10
		if Input.is_action_just_pressed("Shop2") and clicks >= 10:
			speed_boosts += 1
			clicks -= 10
		if Input.is_action_just_pressed("Shop3") and clicks >= clicks_multiplier_price:
			clicks_multipliers += 1;
			clicks -= clicks_multiplier_price

func _on_button_pressed():
	clicks += 1 + 1 * clicks_multipliers
