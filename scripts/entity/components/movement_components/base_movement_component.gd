class_name BaseMovementComponent extends CharacterBody2D
## Base movement class which allows the object to move when given input.
## [BR]
## Provides events for when movement events occur.

## Event called when horizontal movement starts. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_horizontal_movement_started(value: float )

## Event called when horizontal movement is happening. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_horizontal_movement(value: float )

## Event called when horizontal movement ends. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_horizontal_movement_cancelled(value: float )

## Event called when a jump starts. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_jump_started()

## Event called when the entity becomes grounded after not being grounded.
signal on_grounded_start()

## Event called when the entity becomes airborne.
signal on_airborne_start()

## If the entity was grounded in the last physics frame.
var _was_grounded: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_error('Abstract Class Instaniation Error: %s' % [name])
	assert (false, 'Abstract Class Instaniation Error: %s' % [name])

## Determines whether or not the entity is grounded or airborne this frame and
## saves the current state for use next frame.
func _physics_process(_delta: float) -> void:
	_try_to_run_grounded_events()
	_was_grounded = is_on_floor()

## Determines if the signal on_grounded_start and on_airborne_start signals
## should be invoked and then invokes them if they should.
func _try_to_run_grounded_events():
	if _was_grounded && !is_on_floor():
		on_airborne_start.emit()
	elif  !_was_grounded && is_on_floor():
		on_grounded_start.emit()

## Updates the velocity of the entity if it is grounded.
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

## What the entity does when it receives movement input. Should be implemented in child class.
@warning_ignore("UNUSED_PARAMETER")
func on_movement_input(horizontal_vector2: float) -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])


## What the entity does when it receives jump started input. Should be implemented in child class.
func on_jump_input_started() -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])


## What the entity does when it receives jump input. Should be implemented in child class.
func on_jump_input() -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])


## What the entity does when it receives jump cancelled input. Should be implemented in child class.
func on_jump_input_cancelled() -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
