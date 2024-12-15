extends CharacterBody2D

# Enemy states
enum State {
	IDLE,
	CHASE,
	CHARGE,
	ATTACK
}

# Editable properties
@export var move_speed: float = 50.0
@export var chase_speed: float = 70.0
@export var dash_speed: float = 200.0
@export var attack_range: float = 120.0
@export var charge_time: float = 0.5
@export var dash_duration: float = 0.4
@export var jump_speed: float = -200.0
@export var vision_length: float = 300.0
@export var forward_check_distance: float = 20.0
@export var ledge_check_distance: float = 40.0

@export() var player_path: NodePath

var state = State.IDLE
var direction = 1 # 1 = facing right, -1 = facing left
var charge_timer = 0.0
var dash_timer = 0.0
var dash_direction = 1

var player: Node = null # Assign player reference at runtime if possible

func _ready():
	player = get_node(player_path)
	$left_vision.enabled = true
	$right_vision.enabled = true
	$ledge_check.enabled = true
	$front_check.enabled = true
	$Area2D.connect("body_entered", _on_Area2D_body_entered)

func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			handle_idle_state(delta)
		State.CHASE:
			handle_chase_state(delta)
		State.CHARGE:
			handle_charge_state(delta)
		State.ATTACK:
			handle_attack_state(delta)

	# Apply gravity (if any) and move
	velocity += get_gravity() * delta
	move_and_slide()

func _on_Area2D_body_entered(body):
	# Check if the body is the player
	if body.get_parent() == player:
		# Call a method on the player, e.g., apply damage
		if "take_damage" in player.get_child(1):
			if(state == State.ATTACK):
				player.get_child(1).take_damage(5)
			else:
				player.get_child(1).take_damage(1)
			

func handle_idle_state(delta: float) -> void:
	# Basic patrol behavior
	if not $ledge_check.is_colliding():
		turn_around()

	if $front_check.is_colliding():
		turn_around()

	# Move horizontally
	velocity.x = move_speed * sign($front_check.target_position.x)

	# Check vision
	if can_see_player():
		state = State.CHASE

func handle_chase_state(delta: float) -> void:
	if player == null:
		# If no reference to player, revert to idle
		state = State.IDLE
		return

	var distance_to_player = (player.global_position - global_position).length()
	if distance_to_player > attack_range:
		# Move towards player
		var dir_to_player = sign(player.global_position.x - global_position.x)
		direction = dir_to_player
		velocity.x = direction * chase_speed
	else:
		# Close enough to begin charge
		state = State.CHARGE
		charge_timer = charge_time
		velocity.x = 0.0

func handle_charge_state(delta: float) -> void:
	charge_timer -= delta
	if charge_timer <= 0:
		# Ready to attack
		state = State.ATTACK
		dash_timer = dash_duration
		if player != null:
			dash_direction = sign(player.global_position.x - global_position.x)
		else:
			# If player reference lost, just dash in facing direction
			dash_direction = direction

func handle_attack_state(delta: float) -> void:
	velocity.x = dash_direction * dash_speed
	dash_timer -= delta
	if dash_timer <= 0:
		# Attack done, revert to idle
		state = State.IDLE
		velocity.x = move_speed * direction

func can_see_player() -> bool:
	if player == null:
		return false

	var left_hit = $left_vision.get_collider() == player.get_child(0)
	var right_hit = $right_vision.get_collider() == player.get_child(0)
	return left_hit or right_hit

func turn_around() -> void:
	$front_check.target_position.x *= -1
	$ledge_check.target_position.x *= -1
	direction = -direction
