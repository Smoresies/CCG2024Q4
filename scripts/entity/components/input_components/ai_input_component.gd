class_name AiInputComponent extends BaseInputComponent

@export var initial_state: BaseInputState

var current_state: BaseInputState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = initial_state

func _physics_process(_delta: float) -> void:
	emit_signals()
	try_to_change_state()

func emit_signals() -> void:
	if current_state.is_jump_started():
		on_jump_input_started.emit()
	if current_state.is_jump():
		on_jump_input.emit()
	if current_state.is_jump_cancelled():
		on_jump_input_cancelled.emit()

	if current_state.is_attack_started():
		on_attack_input_started.emit()
	if current_state.is_attack():
		on_attack_input.emit()
	if current_state.is_attack_cancelled():
		on_attack_input_cancelled.emit()

	var horizontal_movement: int = current_state.on_horizontal_movement()
	if horizontal_movement != 0:
		on_horizontal_movement_input.emit(horizontal_movement)

	var vertical_movement: int = current_state.on_vertical_movement()
	if vertical_movement != 0:
		on_vertical_movement_input.emit(vertical_movement)

func try_to_change_state() -> void:
	var next_state: BaseInputState = current_state.transition_to_next_state()
	if next_state != current_state:
		current_state.on_state_exited()
		next_state.on_state_entered(current_state)
		current_state = next_state