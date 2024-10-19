class_name BaseHealthAndStatusComponent extends Node

## Event called when the health changes. Should be implemented in the child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_health_changed(current_health: int)

## Event called when the entity dies. Should be implemented in the child class.
@warning_ignore("UNUSED_SIGNAL")
signal on_death()

## The current health of the entity.
var health: int = 100

## The maximum health of the entity.
@export var max_health: int = 100

## The defense stat of the enemy, which reduces incoming damage.
@export var defense: int = 10

## Determines whether the entity is alive.
var is_alive: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_error('Abstract Class Instaniation Error: %s' % [name])
	assert (false, 'Abstract Class Instaniation Error: %s' % [name])


## Reduces health based on the damage taken and the enemy's defense.
## [param damage] int: The raw damage taken.
func take_damage(damage: int) -> void:
	if is_alive:
		var final_damage = max(damage - defense, 0)  # Ensures defense doesn't heal the enemy
		health -= final_damage
		_check_health_status()


## Heals the enemy, ensuring it doesn't go over max health.
## [param heal_amount] int: The amount of health to restore.
func heal(heal_amount: int) -> void:
	if is_alive:
		health = min(health + heal_amount, max_health)
		on_health_changed.emit(health)


## Checks the enemy's health and emits death or health change signals.
func _check_health_status() -> void:
	if health <= 0:
		is_alive = false
		on_death.emit()
	else:
		on_health_changed.emit()