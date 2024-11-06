class_name ClimbableArea extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D ):
	var parent: BaseEntity = body.get_parent()
	var movement_component: BaseMovementComponent = parent.movement_component
	movement_component._on_entered_climbable()
	print(body.to_string() + " entered climbable")

func _on_body_exited(body: Node2D ):
	var parent: BaseEntity = body.get_parent()
	var movement_component: BaseMovementComponent = parent.movement_component
	movement_component._on_exited_climbable()
	print(body.to_string() + " exited climbable")
