class_name BaseCollidableObject extends Area2D

## Signal that is emitted when an entity is hit.
signal on_destroy()

## Damage inflicted by the collidable.
@export var damage: int
@export var healing: int
@export var status_effects: Array[BaseStatusEffect]

func _ready() -> void:
	# Connect the area_entered signal
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.get_parent() is BaseEntity:
		var parent: BaseEntity = body.get_parent()
		_deal_damage(parent)
		_heal_health(parent)
		_apply_status_effects(parent)
	
	on_destroy.emit()
	# TODO: disable the projectile's texture and hitbox
	await get_tree().create_timer(1.0).timeout # Wait for the sound effect to finish
	queue_free()

func _deal_damage(entity: BaseEntity) -> void:
	var parent_health_component: BaseHealthAndStatusComponent = entity.health_and_status_component
	parent_health_component.take_damage(damage)

func _heal_health(entity: BaseEntity) -> void:
	var parent_health_component: BaseHealthAndStatusComponent = entity.health_and_status_component
	parent_health_component.heal_health(healing)

func _apply_status_effects(entity: BaseEntity):
	var parent_health_component: BaseHealthAndStatusComponent = entity.health_and_status_component
	for status_effect in status_effects:
		parent_health_component.apply_status_effect(status_effect)
