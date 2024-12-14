class_name BaseAttack extends Node

@export var base_attack_damage: int
@export var base_attack_hit_effects: Array[BaseStatusEffect]
@export var base_attack_healing: int
@export var base_attack_cooldown_in_seconds: float

var cooldown_timer: Timer
var can_attack: bool

func _ready() -> void:
    cooldown_timer = Timer.new()
    cooldown_timer.wait_time = base_attack_cooldown_in_seconds
    cooldown_timer.autostart = false
    cooldown_timer.timeout.connect(enable_attacking)

    add_child(cooldown_timer)
    pass

func start_attack(_target: Node2D):
    pass

func attack(_target: Node2D):
    pass

func cancel_attack(_target: Node2D):
    pass

func enable_attacking() -> void:
    can_attack = true

func start_attack_cooldown() -> void:
    can_attack = false
    cooldown_timer.start()