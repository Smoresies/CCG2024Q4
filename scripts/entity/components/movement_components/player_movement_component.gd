class_name PlayerMovementComponent extends BaseMovementComponent
## The movement implementation for a human player.

signal on_moth_jump()

signal on_moth_jump_ended()

## The max horizontal speed the entity can move.
@export var MAX_SPEED: int = 200
## The jump velocity of the entity.
@export var JUMP_VELOCITY: int = 350
## The horizontal movement acceleration for the entity.
@export var ACCELERATION: int = 1500
## The time it takes to fully decelerate from horizontal input in seconds.
@export_range(0, 10, 0.1, "or_greater") var DECELERATION_TIME: float = 0.2

## Moth Jump variables
@export var MOTH_JUMP_HANGTIME: float = 1.0
@export var MOTH_JUMP_DIP_AMOUNT: float = 18.0
@export var MOTH_JUMP_FLUTTER_DURATION: float = 0.35

## The current input direction.
var _current_input_direction: float = 0
## How fast the character decelerates after loss of input.
var _horizontal_deceleration: float = MAX_SPEED / DECELERATION_TIME

## Moth Jump state variables
var _is_moth_jumping: bool = false
var _is_fluttering: bool = false
var _moth_jump_timer: float = 0.0
var _moth_jump_flutter_timer: float = 0.0
var _moth_jump_initial_height: float = 0.0
var _is_jump_button_held: bool = false


func _ready() -> void:
	JUMP_VELOCITY *= -1
	MOTH_JUMP_DIP_AMOUNT *= -1
	pass

## Applies movement to the character.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	apply_gravity(delta)
	apply_horizontal_movement(delta)
	move_and_slide()

func on_movement_input(horizontal_vector2: float) -> void:
	_current_input_direction = horizontal_vector2

func on_jump_input_started() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		on_jump_started.emit()
	elif not _is_moth_jumping:
		# Start Moth Jump
		_init_moth_jump()
		
		

func on_jump_input() -> void:
	_is_jump_button_held = true

func on_jump_input_cancelled() -> void:
	_is_jump_button_held = false

## Moves the entity based on the current input direction.
func apply_horizontal_movement(delta: float) -> void:
	if _current_input_direction != 0:
		# Accelerate towards the target speed
		velocity.x = move_toward(velocity.x, _current_input_direction * MAX_SPEED, ACCELERATION * delta)
	else:
		# Decelerate towards zero speed
		velocity.x = move_toward(velocity.x, 0, _horizontal_deceleration * delta)

func apply_gravity(delta: float) -> void:
	if _is_moth_jumping:
		if _is_fluttering:
			
			_apply_moth_jump_dip(delta)
			
			_moth_jump_flutter_timer += delta
			if _moth_jump_flutter_timer >= MOTH_JUMP_FLUTTER_DURATION:
				_is_fluttering = false
				velocity.y = 0.0
				on_moth_jump_ended.emit()

		else:
			if _is_jump_button_held and _moth_jump_timer < MOTH_JUMP_HANGTIME:
				# Maintain the current height
				velocity.y = 0.0
				_moth_jump_timer += delta

			else:
				# End Moth Jump
				_is_moth_jumping = false
				super.apply_gravity(delta)  # Resume normal gravity

	else:
		# Apply normal gravity
		super.apply_gravity(delta)


func _init_moth_jump() -> void:
	_is_moth_jumping = true
	_is_fluttering = true
	_moth_jump_timer = 0.0
	_moth_jump_flutter_timer = 0.0
	_moth_jump_initial_height = global_position.y
	_is_jump_button_held = true
	on_moth_jump.emit()
	
	
func _apply_moth_jump_dip(delta: float) -> void:
	# Handle the flutter dip
	var flutter_progress: float = _moth_jump_flutter_timer / MOTH_JUMP_FLUTTER_DURATION
	# Copy in to desmos to see why I chose this function: -\sin\left(\frac{\left(x-a\right)^{2}}{c}\right)+1
	var flutter_dip: float = -MOTH_JUMP_DIP_AMOUNT * (-sin((pow((flutter_progress-0.5),2))/0.16) + 1)
	var desired_position_y: float = _moth_jump_initial_height + flutter_dip
	var position_difference_y: float = desired_position_y - global_position.y
	velocity.y = position_difference_y / delta
