class_name GlobalStatusEffect extends Resource

@export var cost: int

@export var status_effect: BaseStatusEffect

@export var affects_player: bool

@export var affects_enemy: bool

var effect_active: bool = false

func can_activate(total_currency: int) -> bool:
    return total_currency >= cost and !effect_active