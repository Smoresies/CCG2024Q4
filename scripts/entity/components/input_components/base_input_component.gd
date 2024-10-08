class_name BaseInputComponent extends Node


## Event called when the jump input starts.
signal on_jump_input_started()
## Event called when the jump input is held.
signal on_jump_input()
## Event called when the jump input releases.
signal on_jump_input_cancelled()


## Event called when the horizontal input is held.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement_input(horizontal_value: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_error('Abstract Class Instaniation Error: %s' % [name])
	assert (false, 'Abstract Class Instaniation Error: %s' % [name])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_jump_input_started():
		on_jump_input_started.emit()
	if is_jump_input():
		on_jump_input.emit()
	if is_jump_input_cancelled():
		on_jump_input_cancelled.emit()

	on_horizontal_movement_input.emit(get_horizontal_movement_input())
	

func is_jump_input_started() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false
func is_jump_input() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false

func is_jump_input_cancelled() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false

func get_horizontal_movement_input() -> float:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return 0
