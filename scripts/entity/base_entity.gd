class_name BaseEntity extends Node

@export var movement_component: BaseMovementComponent
@export var input_component: BaseInputComponent
@export var health_and_status_component: BaseHealthAndStatusComponent
@export var attack_components: Array[BaseAttackComponent]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
