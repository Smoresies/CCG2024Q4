class_name ReplaceAttackStatusEffect extends BaseStatusEffect

@export var replacement_attack: PackedScene

func apply_status_effect(entity: BaseEntity) -> void:
    entity.attack_component.replace_attack1(replacement_attack)