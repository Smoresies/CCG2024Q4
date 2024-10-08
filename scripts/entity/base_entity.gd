class_name BaseEntity extends Node

@export var movement_component: BaseMovementComponent
@export var input_component: BaseInputComponent
@export var health_and_status_component: BaseHealthAndStatusComponent
@export var attack_components: Array[BaseAttackComponent]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_component.on_horizontal_movement_input.connect(movement_component.on_movement)

	input_component.on_jump_input_started.connect(movement_component.on_jump_started)
	input_component.on_jump_input_started.connect(say_something)
	
	input_component.on_jump_input.connect(movement_component.on_jump)
	input_component.on_jump_input_cancelled.connect(movement_component.on_jump_cancelled)

func say_something():
	print("something")
