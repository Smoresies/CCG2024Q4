class_name AiAttackComponent extends BaseAttackComponent

## The Area2D that the character locks onto the _current_target.
@export var search_area: Area2D

var _current_target: Node2D = null

func _add_target(body: Node2D) -> void:
	_current_target = body

func _remove_target(_body: Node2D) -> void:
	_current_target = null

func _ready() -> void:
	search_area.body_entered.connect(_add_target)
	search_area.body_exited.connect(_remove_target)

func on_attack_input_started() -> void:
	var executed: bool = attacks[0].start_attack(_get_current_target_or_direction())
	if executed:
		on_attack_started.emit()

func on_attack_input() -> void:
	var executed: bool = attacks[0].attack(_get_current_target_or_direction())
	if executed:
		on_attack.emit()


func on_attack_input_cancelled() -> void:
	var executed: bool = attacks[0].cancel_attack(_get_current_target_or_direction())
	if executed:
		on_attack_cancelled.emit()

## Gets the current _current_target or the direction we are facing.
func _get_current_target_or_direction():
	if is_instance_valid(_current_target):
		return _current_target
	else:
		return _current_direction_facing
