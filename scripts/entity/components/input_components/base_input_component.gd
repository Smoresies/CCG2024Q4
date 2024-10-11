## A base class that is meant to be overwrote in order to provide a conssitent
## way to deal with input while also providing most basic logic.
class_name BaseInputComponent extends Node

## Event called when the jump input starts.
signal on_jump_input_started()
## Event called when the jump input is held.
signal on_jump_input()
## Event called when the jump input releases.
signal on_jump_input_cancelled()

## Event called when the horizontal input is held.
## [br]
## [param horizontal_value] float: The horizontal input value.
signal on_horizontal_movement_input(horizontal_value: float)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_error('Abstract Class Instaniation Error: %s' % [name])
	assert (false, 'Abstract Class Instaniation Error: %s' % [name])


## Gets if the jump input just started. Needs to be overwrote.
func jump_input_started() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false


## Gets if the jump input is currently pressed. Needs to be overwrote.
func jump_input() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false


## Gets if the jump input just finished. Needs to be overwrote.
func jump_input_cancelled() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false


## Gets the current combined left and right input. Needs to be overwrote.
func horizontal_movement_input() -> float:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return 0
