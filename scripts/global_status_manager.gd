class_name GlobalStatusManager extends Node

@export var global_status_effects: Array[GlobalStatusEffect]

var player_status_effects: Dictionary

var enemy_status_effects: Dictionary

var total_currency: int

func add_global_status_effect(global_status_effect: GlobalStatusEffect) -> void:
    if global_status_effect.can_activate(total_currency):
        if global_status_effect.affects_enemy:
            enemy_status_effects.get_or_add(global_status_effect)
        if global_status_effect.affects_player:
            player_status_effects.get_or_add(global_status_effect)