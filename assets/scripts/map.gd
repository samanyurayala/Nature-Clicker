extends Node2D

@onready var clicks_counter = $CanvasLayer/Label
@onready var player = $CharacterBody2D
@onready var label_3 = $Labels/Label3
@onready var label_5 = $Labels/Label5

var clicks = 0
var clicker_helpers = 0
var clicker_price = 15
var clicks_multipliers = 0
var clicks_multiplier_price = 20
var speed_boosts = 0
var jump_boosts = 0
var random = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clicks_counter.text = "Clicks: " + str(round(clicks))
	label_3.text = "Clicker \n Helper \n (B) to buy \n Price: " + str(clicker_price)
	label_5.text = "Click \n Multiplier \n (E) to buy \n Price: " + str(clicks_multiplier_price)
	clicks += 0.0001 * clicker_helpers
	if player.position.x > 3704 and player.position.y <= -290 and player.position.x <= 3775:
		player.position = Vector2(216, 117.9969)
	if player.position.y >= 140:
		player.position = Vector2(216, 117.9969)
		clicks = 0
	print(player.global_transform.origin)

func _physics_process(delta):
	player.jump_velocity = -250 - 0.25 * jump_boosts
	# Handle sprint. 
	if Input.is_action_pressed("Sprint"):
		player.speed = (50.0 + 0.1 * speed_boosts) * 2
	else:
		player.speed = 50.0 + 0.1 * speed_boosts
	
	if player.position.x >= 2972 and player.position.x <= 3120:
		if Input.is_action_just_pressed("Shop1") and clicks >= clicker_price:
			clicker_helpers += 1
			clicks -= clicker_price
			clicker_price += 10
		if Input.is_action_just_pressed("Shop2") and clicks >= 10:
			speed_boosts += 1
			clicks -= 10
		if Input.is_action_just_pressed("Shop3") and clicks >= clicks_multiplier_price:
			clicks_multipliers += 1;
			clicks -= clicks_multiplier_price
			clicks_multiplier_price += 15
		if Input.is_action_just_pressed("Shop4") and clicks >= 10:
			jump_boosts += 1;
			clicks -= 10;

func _on_button_pressed():
	clicks += 1 + 1 * clicks_multipliers


func _on_area_2d_area_entered(area):
	if area.is_in_group("mystery_box"):
		random = randi_range(1, 2)
		if random == 2:
			player.position = Vector2(216, 117.9969)
			clicks = 0
		else:
			random = randi_range(50, 100)
			clicks += random
