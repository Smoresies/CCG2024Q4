class_name PlayerAnimationController
extends AnimationPlayer

@export var animated_sprite: AnimatedSprite2D
@export var player: CharacterBody2D

func change_dir(dir: float):
	if dir > 0:
		animated_sprite.flip_h = false
	elif dir < 0:
		animated_sprite.flip_h = true

func walking(dir: float):
	change_dir(dir)
	
	if player.is_on_floor():
		play(&"walking")

func idle():
	if player.is_on_floor():
		play(&"idle")
