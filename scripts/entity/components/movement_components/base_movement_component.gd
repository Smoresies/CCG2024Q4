class_name BaseMovementComponent extends CharacterBody2D
## Base movement class which allows the object to move when given input.
## [BR]
## Provides events for when movement events occur.

## Event called when horizontal movement starts. Should be implemented in child class.
signal on_horizontal_movement_started(value: float )

## Event called when horizontal movement is happening. Should be implemented in child class.
signal on_horizontal_movement(value: float )

## Event called when horizontal movement ends. Should be implemented in child class.
signal on_horizontal_movement_cancelled(value: float )

## Event called when vertical movement starts. Should be implemented in child class.
signal on_vertical_movement_started(value: float )

## Event called when vertical movement is happening. Should be implemented in child class.
signal on_vertical_movement(value: float )

## Event called when vertical movement ends. Should be implemented in child class.
signal on_vertical_movement_cancelled(value: float )

## Event called when a jump starts. Should be implemented in child class.
signal on_jump_started()

## Event called when the entity becomes grounded after not being grounded.
signal on_grounded_start()

## Event called when the entity becomes airborne.
signal on_airborne_start()

## Event called when the entity changes direction.
signal on_direction_changed(value: float)

## If the entity was grounded in the last physics frame.
var _was_grounded: bool

## The horizontal velocity last physics frame.
var _previous_horizontal_velocity: float = 0

## The vertical velocity last physics frame.
var _previous_vertical_velocity: float = 0

## The current direction the character is facing. 1 being right.
var _current_direction: int = 1

## Climbing booleans
var _is_climbing: bool = false
var _can_climb: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utilities.make_abstract_class(name)


## Determines whether or not the entity is grounded or airborne this frame and
## saves the current state for use next frame.
func _physics_process(_delta: float) -> void:
	_emit_movement_signals()
	_try_to_run_grounded_events()
	_was_grounded = is_on_floor()
	try_to_emit_signal_direction_change()
	_previous_horizontal_velocity = velocity.x
	_previous_vertical_velocity = velocity.y


## What the entity does when it receives horizontal movement input. Should be implemented in child class.
@warning_ignore("UNUSED_PARAMETER")
func on_horizontal_movement_input(horizontal_vector2: float) -> void:
	Utilities.make_abstract_function(name)

## What the entity does when it receives vertical movement input. Should be implemented in child class.
@warning_ignore("UNUSED_PARAMETER")
func on_vertical_movement_input(horizontal_vector2: float) -> void:
	Utilities.make_abstract_function(name)

## What the entity does when it receives jump started input. Should be implemented in child class.
func on_jump_input_started() -> void:
	Utilities.make_abstract_function(name)


## What the entity does when it receives jump input. Should be implemented in child class.
func on_jump_input() -> void:
	Utilities.make_abstract_function(name)


## What the entity does when it receives jump cancelled input. Should be implemented in child class.
func on_jump_input_cancelled() -> void:
	Utilities.make_abstract_function(name)


## Calls the movement signals using the given velocity and previous velocity
func _emit_movement_signals() -> void:
	if(velocity.x == 0 && _previous_horizontal_velocity != 0):
		on_horizontal_movement_cancelled.emit(velocity.x)
	elif(velocity.x != 0 && _previous_horizontal_velocity == 0):
		on_horizontal_movement_started.emit(velocity.x)
	elif velocity.x != 0 && _previous_horizontal_velocity != 0:
		on_horizontal_movement.emit(velocity.x)
	
	if(velocity.y == 0 && _previous_vertical_velocity != 0):
		on_vertical_movement_cancelled.emit(velocity.y)
	elif(velocity.y != 0 && _previous_vertical_velocity == 0):
		on_vertical_movement_started.emit(velocity.y)
	elif velocity.y != 0 && _previous_vertical_velocity != 0:
		on_vertical_movement.emit(velocity.y)

	

## Determines if the signal on_grounded_start and on_airborne_start signals
## should be invoked and then invokes them if they should.
func _try_to_run_grounded_events() -> void:
	if _was_grounded && !is_on_floor():
		on_airborne_start.emit()
	elif  !_was_grounded && is_on_floor():
		on_grounded_start.emit()


## Updates the velocity of the entity if it is grounded.
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

## Emits the signal direction change when 
func try_to_emit_signal_direction_change():
	if velocity.x > 0 and _current_direction < 0:
		_current_direction = 1
		on_direction_changed.emit(_current_direction)
	elif velocity.x < 0 and _current_direction > 0:
		_current_direction = -1
		on_direction_changed.emit(_current_direction)

func _on_entered_climbable() -> void:
	_is_climbing = true
	_can_climb = true
	print("Entered climbable area")

func _on_exited_climbable() -> void:
	_is_climbing = false
	_can_climb = false
	print("Exited climbable area")