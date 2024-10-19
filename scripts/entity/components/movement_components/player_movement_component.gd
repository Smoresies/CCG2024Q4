class_name PlayerMovementComponent extends BaseMovementComponent
## The movement implementation for a human player.

## The max horizontal speed the entity can move.
@export var MAX_SPEED: int = 200
## The jump velocity of the entity.
@export var JUMP_VELOCITY: int = -300
## The horizontal movement acceleration for the entity.
@export var ACCELERATION: int = 1500
## The time it takes to fully decelerate from horizontal input in seconds.
@export_range(0, 10, 0.1, "or_greater") var DECELERATION_TIME: float = 0.2

## The current input direction.
var _current_input_direction: float = 0
## How fast the character decelerates after loss of input.
var _horizontal_deceleration: float = MAX_SPEED / DECELERATION_TIME

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#do nothing
	pass


## Applies movement to the character.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	apply_gravity(delta)	
	apply_horizontal_movement(delta)
	move_and_slide()


func on_movement_input(horizontal_vector2: float) -> void:
	_current_input_direction = horizontal_vector2


func on_jump_input_started() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		on_jump_started.emit()


func on_jump_input() -> void:
	# do nothing
	pass


func on_jump_input_cancelled() -> void:
	# do nothing
	pass


## Moves the entity based on the current input direction.
func apply_horizontal_movement(delta: float) -> void:
 	# Direction button active
	if _current_input_direction:
		# Accelerate towards the target speed
		velocity.x = move_toward(velocity.x, _current_input_direction * MAX_SPEED, ACCELERATION * delta)
	 # Direction button inactive
	else:
		# Decelerate towards zero speed
		velocity.x = move_toward(velocity.x, 0, _horizontal_deceleration * delta)
