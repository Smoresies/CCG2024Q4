## A base class that is meant to be overwrote in order to provide a conssitent
## way to deal with input while also providing most basic logic.
class_name BaseInputComponent extends Node

## Event called when the jump input starts. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_jump_input_started()
## Event called when the jump input is held. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_jump_input()
## Event called when the jump input releases. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_jump_input_cancelled()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_input_started()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_input()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_input_cancelled()

## Event called when the horizontal input is held.
## [br]
## [param horizontal_value] float: The horizontal input value. Should be implemented in child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_horizontal_movement_input(horizontal_value: float)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Utilities.make_abstract_class(name)


## Gets if the jump input just started. Needs to be overwrote.
func jump_input_started() -> bool:
	Utilities.make_abstract_function(name)
	return false


## Gets if the jump input is currently pressed. Needs to be overwrote.
func jump_input() -> bool:
	Utilities.make_abstract_function(name)

	return false


## Gets if the jump input just finished. Needs to be overwrote.
func jump_input_cancelled() -> bool:
	Utilities.make_abstract_function(name)

	return false


## Gets the current combined left and right input. Needs to be overwrote.
func horizontal_movement_input() -> float:
	Utilities.make_abstract_function(name)

	return 0
