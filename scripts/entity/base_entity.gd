class_name BaseEntity extends Node
## A base entity class which automatically hooks the initial movement and input together.

## The movement component of the entity.
@export var movement_component: BaseMovementComponent
## The input component of the entity.
@export var input_component: BaseInputComponent
## The health and status component of the entity.
@export var health_and_status_component: BaseHealthAndStatusComponent
## The attack components of the entity.
@export var attack_components: Array[BaseAttackComponent]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# if the movement component and input component exist connect the movement together.
	if movement_component && input_component:
		print("meow")
		input_component.on_horizontal_movement_input.connect(movement_component.on_movement_input)

		input_component.on_jump_input_started.connect(movement_component.on_jump_input_started)
		input_component.on_jump_input.connect(movement_component.on_jump_input)
		input_component.on_jump_input_cancelled.connect(movement_component.on_jump_input_cancelled)
