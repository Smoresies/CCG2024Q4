class_name BaseAttackComponent extends Node

## The attacks the attack component as access to use.
@export var attacks: Array[BaseAttack]

## The node to compare against the targets.
@export var measurement_position: Node2D

## The time between target updates in seconds.
@export var time_between_target_updates_in_seconds: float

## The position the projectile spawns.
@export var projectile_spawn_position: Marker2D

## The current direction we are facing.
var _current_direction_facing: Vector2 = Vector2.RIGHT

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_started()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_cancelled()

func _ready() -> void:
	Utilities.make_abstract_class(name)

func on_attack_input_started() -> void:
	Utilities.make_abstract_function(name)

func on_attack_input() -> void:
	Utilities.make_abstract_function(name)

func on_attack_input_cancelled() -> void:
	Utilities.make_abstract_function(name)

## Replaces the attack in spot 0 of the attack array.
func replace_attack1(attack_scene: PackedScene) -> void:
	attacks[0].queue_free()
	var new_attack: BaseAttack = attack_scene.instantiate()
	add_child(new_attack)
	attacks[0] = new_attack
	if new_attack is RangedAttack:
		(new_attack as RangedAttack).init_attack(projectile_spawn_position)

## Updates the direction of the lock on area and projectile spawn point to the
## other side if the direciton changes.
func update_direction_specific_items(value: float):
	projectile_spawn_position.position.x *= -1
	projectile_spawn_position.scale.x *= -1

	_current_direction_facing.x = value
