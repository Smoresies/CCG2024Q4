class_name PlayerInputComponent extends BaseInputComponent
## An extension to the [BaseInputComponent] class which takes in input from a player input device.


const JUMP_INPUT_NAME: StringName = "jump"
const LEFT_INPUT_NAME: StringName  = "left"
const RIGHT_INPUT_NAME: StringName = "right"


func _ready() -> void:
	# Overwrite the abstract class
	pass

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(JUMP_INPUT_NAME):
		on_jump_input_started.emit()
		on_jump_input.emit()
	elif Input.is_action_pressed(JUMP_INPUT_NAME):
		on_jump_input.emit()
	elif Input.is_action_pressed(JUMP_INPUT_NAME):
		on_jump_input_cancelled.emit()

	on_horizontal_movement_input.emit(Input.get_axis(LEFT_INPUT_NAME, RIGHT_INPUT_NAME))
