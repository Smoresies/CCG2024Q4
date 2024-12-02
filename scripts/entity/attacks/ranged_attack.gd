class_name RangedAttack extends BaseAttack

## The projectile scene to instantiate
@export var projectile_scene: PackedScene
@export var projectile_spawn_position: Marker2D
@export var projectile_speed: int
@export var projectile_sfx: String

func _ready() -> void:
	pass

func start_attack(target_or_direction) -> void:
	# Create an instance of the projectile
	var projectile_instance: BaseProjectileComponent = projectile_scene.instantiate()
	add_child(projectile_instance)
	# Initialize the projectile
	projectile_instance.init(projectile_spawn_position.global_position, base_attack_damage, base_attack_hit_effects, base_attack_healing, projectile_speed, target_or_direction, projectile_sfx)

func attack(_target_or_direction) -> void:
	pass

func cancel_attack(_target_or_direction) -> void:
	pass

func init_attack(new_projectile_spawn_position: Marker2D) -> void:
	projectile_spawn_position = new_projectile_spawn_position
