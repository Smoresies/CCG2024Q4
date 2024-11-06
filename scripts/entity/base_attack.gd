class_name BaseAttack extends Node

@export var base_attack_damage: int
@export var base_attack_hit_effects: Array[BaseStatusEffect]
@export var base_attack_healing: int
@export var base_attack_cooldown_in_seconds: float

func _ready() -> void:
	pass

func start_attack(_target: Node2D):
	pass

func attack(_target: Node2D):
	pass

func cancel_attack(_target: Node2D):
	pass
