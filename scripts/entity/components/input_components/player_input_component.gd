class_name PlayerInputComponent extends BaseInputComponent
## An extension to the [BaseInputComponent] class which takes in input from a player input device.

func _ready() -> void:
	# Overwrite the abstract class
	pass


func is_jump_input_started() -> bool:
	return Input.is_action_just_pressed(JUMP_INPUT_NAME)


func is_jump_input() -> bool:
	return Input.is_action_pressed(JUMP_INPUT_NAME)


func is_jump_input_cancelled() -> bool:
	return Input.is_action_just_released(JUMP_INPUT_NAME)


func get_horizontal_movement_input() -> float:
	return Input.get_axis(LEFT_INPUT_NAME, RIGHT_INPUT_NAME)
