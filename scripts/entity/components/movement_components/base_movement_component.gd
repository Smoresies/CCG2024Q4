class_name BaseMovementComponent extends CharacterBody2D

## Event called when the jump input starts.
signal on_jump_started()
## Event called when the jump input is held.
signal on_jump()
## Event called when the jump input releases.
signal on_jump_cancelled()

## Event called when the horizontal input starts.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement_started(horizontal_vector2: Vector2)
## Event called when the horizontal input is held.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement(horizontal_vector2: Vector2)
## Event called when the horizontal input releases.
## [param_name] horizontal_vector2: The horizontal vector.
signal on_horizontal_movement_cancelled(horizontal_vector2: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_error('Abstract Class Instaniation Error: %s' % [name])
	assert (false, 'Abstract Class Instaniation Error: %s' % [name])

func _physics_process(delta: float) -> void:
	push_error('Unimplemented Method Error: %s' % [name])
	assert (false, 'Unimplemented Method Error: %s' % [name])
