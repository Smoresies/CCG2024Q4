class_name PlayerAttackComponent extends BaseAttackComponent

@export var projectile_scene: PackedScene # The projectile scene to instantiate
@export var projectile_spawn_position: Node2D
func _ready() -> void:
	# Override the abstract class
	pass

func on_attack_input_started() -> void:
	# Create an instance of the projectile
	var projectile_instance: BaseProjectileComponent = projectile_scene.instantiate()
	add_child(projectile_instance)
	# Initialize the projectile
	projectile_instance.init(projectile_spawn_position.global_position, 5, [1], 0, 200, Vector2.ZERO)
	print("attacked")

func on_attack_input() -> void:
	pass

func on_attack_input_cancelled() -> void:
	pass
