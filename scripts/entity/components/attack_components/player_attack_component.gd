class_name PlayerAttackComponent extends BaseAttackComponent

@export var projectile_scene: PackedScene  # The projectile scene to instantiate

func _ready() -> void:
    # Override the abstract class
    pass

func on_attack_input_started() -> void:
    # Create an instance of the projectile
    var projectile_instance = projectile_scene.instantiate()
    
    # Set the position to the player's position
    projectile_instance.init(5, [1], 0, 200)
    
    # Add the projectile to the scene tree
    get_tree().current_scene.add_child(projectile_instance)
