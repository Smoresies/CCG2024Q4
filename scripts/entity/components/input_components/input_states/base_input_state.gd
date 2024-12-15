class_name BaseInputState extends Node

@export var transition_states: Array[BaseInputState]

func can_enter_state() -> bool:
    return true

func can_exit_state() -> bool:
    return true

func on_state_entered(_previous_state: BaseInputState) -> void:
    pass

func on_state_exited() -> void:
    pass

func transition_to_next_state() -> BaseInputState:
    if can_exit_state():
        for state: BaseInputState in transition_states:
            if state.can_enter_state():
                return state

    return self

func is_jump_started() -> bool:
    return false

func is_jump() -> bool:
    return false

func is_jump_cancelled() -> bool:
    return false

func is_attack_started() -> bool:
    return false

func is_attack() -> bool:
    return false

func is_attack_cancelled() -> bool:
    return false

func on_horizontal_movement() -> int:
    return 0

func on_vertical_movement() -> int:
    return 0
