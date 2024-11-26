class_name FlatMoveSpeedAdjustmentStatusEffect extends BaseStatusEffect

@export var flat_move_speed_bonus_adjustment: int

func apply_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_move_speed_bonus += flat_move_speed_bonus_adjustment

func remove_status_effect(entity: BaseEntity) -> void:
    entity.health_and_status_component.flat_move_speed_bonus -= flat_move_speed_bonus_adjustment