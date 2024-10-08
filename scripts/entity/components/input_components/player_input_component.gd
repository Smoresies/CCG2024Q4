class_name PlayerInputComponent extends BaseInputComponent

func _ready() -> void:
	# Overwrite the abstract class
	pass

func is_jump_input_started() -> bool:
	return Input.is_action_just_pressed("jump")

func is_jump_input() -> bool:
	return Input.is_action_pressed("jump")

func is_jump_input_cancelled() -> bool:
	return Input.is_action_just_released("jump")

func get_horizontal_movement_input() -> float:
	return Input.get_axis("left", "right")
