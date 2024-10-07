extends CharacterBody2D

@export var max_health: int = 10
@export var show_health_bar: bool = true

var current_health

@onready var health_bar = $HealthBar

func _ready():
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health
	health_bar.visible = show_health_bar

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		take_damage(1)

func take_damage(amount):
	current_health -= amount
	current_health = max(current_health, 0)
	health_bar.value = current_health
