class_name MoveState extends BaseInputState

@export var horizontal_movement: int
@export var vertical_movement: int

func on_horizontal_movement() -> int:
    return horizontal_movement

func on_vertical_movement() -> int:
    return vertical_movement
