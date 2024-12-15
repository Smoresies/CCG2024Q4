class_name FlatHealAdjustmentStatusEffect extends BaseStatusEffect

@export var flat_heal_bonus_adjustment: int

func apply_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_heal_bonus += flat_heal_bonus_adjustment

func remove_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_heal_bonus   -= flat_heal_bonus_adjustment