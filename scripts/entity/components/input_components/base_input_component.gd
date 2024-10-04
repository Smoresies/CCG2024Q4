class_name BaseInputComponent extends Node


## Event called when the jump input starts.
signal on_jump_input_started()
## Event called when the jump input is held.
signal on_jump_input()
## Event called when the jump input releases.
signal on_jump_input_cancelled()

## Event called when the horizontal input starts.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement_input_started(horizontal_vector2: Vector2)
## Event called when the horizontal input is held.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement_input(horizontal_vector2: Vector2)
## Event called when the horizontal input releases.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement_input_cancelled(horizontal_vector2: Vector2)

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
	if is_horizontal_movement_input_started():
		on_horizontal_movement_input_started.emit(get_horizontal_movement_input_started())
	if is_horizontal_movement_input():
		on_horizontal_movement_input.emit(get_horizontal_movement_input())
	if is_horizontal_movement_input_cancelled():
		on_horizontal_movement_input_cancelled.emit(get_horizontal_movement_input_cancelled())
	

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

func is_horizontal_movement_input_started() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false

func is_horizontal_movement_input() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false

func is_horizontal_movement_input_cancelled() -> bool:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return false

func get_horizontal_movement_input_started() -> Vector2:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return Vector2.ZERO

func get_horizontal_movement_input() -> Vector2:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return Vector2.ZERO

func get_horizontal_movement_input_cancelled() -> Vector2:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
	return Vector2.ZERO
