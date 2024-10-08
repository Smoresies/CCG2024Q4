class_name BaseMovementComponent extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_error('Abstract Class Instaniation Error: %s' % [name])
	#assert (false, 'Abstract Class Instaniation Error: %s' % [name])

func on_movement_started(horizontal_vector2: float) -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_movement(horizontal_vector2: float) -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_movement_cancelled(horizontal_vector2: float) -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_jump_started() -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_jump() -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_jump_cancelled() -> void:
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert (false, 'Abstract Method Not Implemented Error: %s' % [name])
