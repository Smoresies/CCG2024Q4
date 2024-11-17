class_name PlayerAnimationController
extends AnimationPlayer

@export var animated_sprite: AnimatedSprite2D
@export var player: CharacterBody2D

func change_dir(dir: float):
	if dir > 0:
		animated_sprite.flip_h = false
	elif dir < 0:
		animated_sprite.flip_h = true

func walking(_dir: float):
	if player.is_on_floor() and current_animation != "jumping":
		play(&"walking")

func idle():
	if player.is_on_floor():
		play(&"idle")

func jump():
	play(&"jumping")
	await animation_finished
	midair()

func landing():
	play(&"landing")
	# Cheap way to get around the signal 
	await animation_finished
	idle()

func midair():
	play(&"midair")
