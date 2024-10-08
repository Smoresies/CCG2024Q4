class_name PlayerMovementComponent extends BaseMovementComponent

@export var MAX_SPEED: int = 200
@export var JUMP_VELOCITY: int = -300
@export var ACCELERATION: int = 1500
@export_range(0, 10, 0.1, "or_greater") var DECELERATION_TIME: float = 0.2

var current_direction: float = 0

var deceleration: float = MAX_SPEED / DECELERATION_TIME

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#do nothing
	pass

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
		
	apply_horizontal_movement(delta)

	move_and_slide()

func apply_gravity(delta: float):
	# Add the apply_gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func on_movement_started(horizontal_vector2: float) -> void:
	# do nothing
	pass

func on_movement(horizontal_vector2: float) -> void:
	current_direction = horizontal_vector2

func on_movement_cancelled(horizontal_vector2: float) -> void:
	# do nothing
	pass

func on_jump_started() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func on_jump() -> void:
	# do nothing
	pass

func on_jump_cancelled() -> void:
	# do nothing
	pass
	

func apply_horizontal_movement(delta: float):
	if current_direction: # Direction button active
		# Accelerate towards the target speed
		velocity.x = move_toward(velocity.x, current_direction * MAX_SPEED, ACCELERATION * delta)

	else: # Direction button inactive
		# Decelerate towards zero speed
		print(deceleration)
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	
