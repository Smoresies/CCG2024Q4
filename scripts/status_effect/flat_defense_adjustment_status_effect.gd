class_name FlatDefenseAdjustmentStatusEffect extends BaseStatusEffect

@export var flat_defense_bonus_adjustment: int

func apply_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_defense_bonus += flat_defense_bonus_adjustment

func remove_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_defense_bonus -= flat_defense_bonus_adjustment