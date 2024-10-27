class_name BaseProjectileComponent extends BaseCollidableObject


var move_speed: int = 0
var target_location: Node2D
var velocity: Vector2 = Vector2.ZERO

func init(set_starting_position: Vector2, set_damage: int, set_on_hit_effects: Array[BaseStatusEffect], set_healing: int, set_move_speed: int, set_target_or_direction) -> void:
	self.damage = set_damage
	self.status_effects = set_on_hit_effects
	self.healing = set_healing
	self.move_speed = set_move_speed
	global_position = set_starting_position

	var direction: Vector2
	if set_target_or_direction is Node2D:
		target_location = set_target_or_direction
		direction = target_location.global_position - set_starting_position
	elif set_target_or_direction is Vector2:
		direction = set_target_or_direction

		
	velocity = (direction).normalized() * move_speed


func _physics_process(delta: float) -> void:
	position += velocity * delta
