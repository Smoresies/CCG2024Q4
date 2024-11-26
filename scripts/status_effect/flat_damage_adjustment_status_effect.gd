class_name FlatDamageAdjustmentStatusEffect extends BaseStatusEffect

@export var flat_damage_bonus_adjustment: int

func apply_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_damage_bonus += flat_damage_bonus_adjustment

func remove_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_damage_bonus -= flat_damage_bonus_adjustment