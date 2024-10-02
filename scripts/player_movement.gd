class_name Player extends CharacterBody2D


@export var MAX_SPEED: int = 200
@export var JUMP_VELOCITY: int = -300.0
@export var ACCELERATION: int = 1500
@export var DECELERATION_TIME: float = 0.2

var deceleration: float = MAX_SPEED / DECELERATION_TIME

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		# Accelerate towards the target speed
		velocity.x = move_toward(velocity.x, direction * MAX_SPEED, ACCELERATION * delta)
	else:
		# Decelerate towards zero speed
		var deceleration_rate = (MAX_SPEED / DECELERATION_TIME)
		velocity.x = move_toward(velocity.x, 0, deceleration_rate * delta)

	move_and_slide()
