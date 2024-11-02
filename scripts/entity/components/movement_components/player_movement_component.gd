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
var _current_input_direction: Vector2 = Vector2(0,0)

## How fast the character decelerates after loss of input.
var _horizontal_deceleration: float = MAX_SPEED / DECELERATION_TIME

## Moth Jump state variables
var _is_moth_jumping: bool = false
var _can_moth_jump: bool = true
var _is_fluttering: bool = false
var _moth_jump_timer: float = 0.0
var _moth_jump_flutter_timer: float = 0.0
var _moth_jump_initial_height: float = 0.0
var _is_jump_button_held: bool = false

@export var CLIMB_SPEED: int = 300
var _is_climbing: bool = false
var _can_climb: bool = false

func _ready() -> void:
	JUMP_VELOCITY *= -1
	pass

## Applies movement to the character.
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _is_climbing:
		apply_climbing_movement(delta)
	else:
		apply_gravity(delta)
		apply_horizontal_movement(delta)
	move_and_slide()

func on_horizontal_movement_input(horizontal_vector2: float) -> void:
	_current_input_direction.x = horizontal_vector2

func on_vertical_movement_input(vertical_vector2: float) -> void:
	_current_input_direction.y = vertical_vector2

func on_jump_input_started() -> void:
	if is_on_floor():
		_can_moth_jump = true
		velocity.y = JUMP_VELOCITY
		on_jump_started.emit()
	elif not _is_moth_jumping and _can_moth_jump:
		# Start Moth Jump
		_init_moth_jump()

func on_jump_input() -> void:
	_is_jump_button_held = true

func on_jump_input_cancelled() -> void:
	_is_jump_button_held = false
	
func _on_entered_climbable() -> void:
	_is_climbing = true
	_can_climb = true
	print("Entered climbable area")

func _on_exited_climbable() -> void:
	_is_climbing = false
	_can_climb = false
	print("Exited climbable area")


## Moves the entity based on the current input direction.
func apply_horizontal_movement(delta: float) -> void:
	if _current_input_direction.x != 0:
		# Accelerate towards the target speed
		velocity.x = move_toward(velocity.x, _current_input_direction.x * MAX_SPEED, ACCELERATION * delta)
	else:
		# Decelerate towards zero speed
		velocity.x = move_toward(velocity.x, 0, _horizontal_deceleration * delta)

func apply_gravity(delta: float) -> void:
	if not _is_moth_jumping:
		# Apply normal gravity if not jumping
		super.apply_gravity(delta)
		return

	_moth_jump(delta)
	

func _init_moth_jump() -> void:
	_is_moth_jumping = true
	_is_fluttering = true
	_moth_jump_timer = 0.0
	_moth_jump_flutter_timer = 0.0
	_moth_jump_initial_height = global_position.y
	_is_jump_button_held = true
	on_moth_jump.emit()


func _moth_jump(delta: float) -> void:
	#Only one moth jump per airtime
	_can_moth_jump = false

	if _is_fluttering:
		_apply_moth_jump_dip(delta)
		_moth_jump_flutter_timer += delta

		if _moth_jump_flutter_timer >= MOTH_JUMP_FLUTTER_DURATION or not _is_jump_button_held:
			_is_fluttering = false
			velocity.y = 0.0
			on_moth_jump_ended.emit()
		else:
			return

	if _is_jump_button_held and _moth_jump_timer < MOTH_JUMP_HANGTIME:
		velocity.y = 0.0
		_moth_jump_timer += delta
	else:
		_is_moth_jumping = false
		on_moth_jump_ended.emit()
		super.apply_gravity(delta)
	
	
func apply_climbing_movement(delta: float) -> void:
	velocity.y = move_toward(velocity.y, _current_input_direction.y * CLIMB_SPEED, ACCELERATION * delta)

	
func _apply_moth_jump_dip(delta: float) -> void:
	# Handle the flutter dip
	
	# Flutter progress, goes from 0 to MOTH_JUMP_FLUTTER_DURATION. Used as the X for the dip equation
	var flutter_progress: float = _moth_jump_flutter_timer / MOTH_JUMP_FLUTTER_DURATION
	
	# Copy in to desmos to see why I chose this function: -\sin\left(\frac{\left(x-a\right)^{2}}{c}\right)+1
	# Calculate the amount of dip to have based on the time remaining in flutter progress.
	# X|flutter_progress is the amount of time left. Only outputs the range [0,1]
	var bounded_dip_equation = (-sin((pow((flutter_progress - 0.5), 2)) / 0.16) + 1)
	
	# Amplify the dip amount by MOTH_JUMP_DIP_AMOUNT
	var flutter_dip: float = MOTH_JUMP_DIP_AMOUNT * bounded_dip_equation
	
	# Calculate the desired Y every frame: matches the amplified curve.
	var desired_position_y: float = _moth_jump_initial_height + flutter_dip
	
	# Applies the position offset
	var position_difference_y: float = desired_position_y - global_position.y
	velocity.y = position_difference_y / delta
