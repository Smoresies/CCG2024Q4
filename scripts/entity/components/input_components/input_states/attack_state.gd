class_name AttackState extends BaseInputState

## The Area2D that the character locks onto the _current_target.
@export var search_area: Area2D

var _current_target: Node2D = null

func _ready() -> void:
    search_area.body_entered.connect(_add_target)
    search_area.body_exited.connect(_remove_target)

func is_attack_started() -> bool:
    return _current_target != null

func is_attack() -> bool:
    return _current_target != null

func _add_target(body: Node2D) -> void:
    _current_target = body

func _remove_target(_body: Node2D) -> void:
    _current_target = null
