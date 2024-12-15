class_name NoMovementComponent extends BaseMovementComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


## Determines whether or not the entity is grounded or airborne this frame and
## saves the current state for use next frame.
func _physics_process(_delta: float) -> void:
	pass


## What the entity does when it receives horizontal movement input. Should be implemented in child class.
@warning_ignore("UNUSED_PARAMETER")
func on_horizontal_movement_input(horizontal_vector2: float) -> void:
	pass

## What the entity does when it receives vertical movement input. Should be implemented in child class.
@warning_ignore("UNUSED_PARAMETER")
func on_vertical_movement_input(horizontal_vector2: float) -> void:
	pass

## What the entity does when it receives jump started input. Should be implemented in child class.
func on_jump_input_started() -> void:
	pass


## What the entity does when it receives jump input. Should be implemented in child class.
func on_jump_input() -> void:
	pass


## What the entity does when it receives jump cancelled input. Should be implemented in child class.
func on_jump_input_cancelled() -> void:
	pass