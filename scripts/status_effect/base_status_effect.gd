class_name BaseStatusEffect extends Resource

@export var one_shot: bool
@export var effect_duration_in_seconds: float

func apply_status_effect(_entity: BaseEntity) -> void:
    Utilities.make_abstract_function(get_name())

func remove_status_effect(_entity: BaseEntity) -> void:
    Utilities.make_abstract_function(get_name())