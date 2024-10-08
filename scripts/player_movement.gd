class_name Player extends CharacterBody2D

@export var MAX_SPEED: int = 200
@export var JUMP_VELOCITY: int = -300.0
@export var ACCELERATION: int = 1500
@export_range(0, 10, 0.1, "or_greater") var DECELERATION_TIME: float = 0.2

var deceleration: float = MAX_SPEED / DECELERATION_TIME

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	apply_player_jump()
	
	apply_horizontal_movement(delta)

	move_and_slide()


func apply_gravity(delta: float):
	# Add the apply_gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func apply_player_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func apply_horizontal_movement(delta: float):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction: # Direction button active
		# Accelerate towards the target speed
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)

	else: # Direction button inactive
		# Decelerate towards zero speed
		print(deceleration)
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
	
