class_name BaseHealthAndStatusComponent extends Node


signal on_death()
@warning_ignore("UNUSED_SIGNAL")
signal on_damage_taken()
@warning_ignore("UNUSED_SIGNAL")
signal on_healed()
@warning_ignore("UNUSED_SIGNAL")
signal on_attack()
@warning_ignore("UNUSED_SIGNAL")
signal on_move()


var status_effects: Array = []


## The maximum health of the entity.
@export var max_health: int = 10
## The current health of the entity.
var _current_health: int = max_health


## Bonuses
var flat_defense_bonus: int = 0
var percent_defense_bonus: float = 1
var flat_heal_bonus: int = 0
var percent_heal_bonus: float = 1
var flat_damage_bonus: int = 0
var percent_damage_bonus: float = 1
var flat_move_speed_bonus: int = 0
var percent_move_speed_bonus: float = 1

func _ready() -> void:
	on_death.connect(_die)

# func add_status_effect(status_effect: StatusEffect):
	# TBD


# func remove_status_effect(status_effect: StatusEffect):
	# TBD


## Reduces health based on the damage taken and the entity's defense.
## [param damage_to_take] int: The raw damage taken.
func take_damage(damage_to_take: int) -> void:
	var final_damage = max((damage_to_take - flat_defense_bonus) * percent_defense_bonus, 0)
	_current_health -= final_damage
	on_damage_taken.emit()

	if _current_health <= 0:
		on_death.emit()




## Heals the entity, ensuring it doesn't go over max health.
## [param health_to_heal] int: The amount of health to restore.
func heal_damage(health_to_heal: int) -> void:
	if _current_health > 0:
		var final_health_gain: int = min((_current_health + health_to_heal + flat_heal_bonus) * percent_heal_bonus)
		_current_health = min(final_health_gain, max_health)
		on_healed.emit()

## Free's the queue of the entity
func _die() -> void:
	self.get_parent().queue_free()
