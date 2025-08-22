extends CharacterBody2D

@onready var player_anim = $AnimatedSprite2D

var speed = 50.0
const JUMP_VELOCITY = -250.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	# Handle plaer facing. 
	if direction > 0:
		player_anim.flip_h = false
	elif direction < 0:
		player_anim.flip_h = true

	_animations()

func _animations():
	if velocity.x == 0 and velocity.y == 0:
		player_anim.pause()
	if velocity.x != 0 and velocity.y == 0:
		if speed == 100.0:
			player_anim.play("run")
		else:
			player_anim.play("walk")
	if velocity.x != 0 and velocity.y != 0:
		player_anim.play("jump")
	if velocity.x == 0 and velocity.y != 0:
		player_anim.play("jump")
