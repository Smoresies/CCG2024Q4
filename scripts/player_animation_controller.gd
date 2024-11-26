class_name PlayerAnimationController
extends AnimationPlayer

@export var animated_sprite: AnimatedSprite2D
@export var player: CharacterBody2D

func change_dir(dir: float):
	if dir > 0:
		animated_sprite.flip_h = false
	elif dir < 0:
		animated_sprite.flip_h = true

func play_walking_animation(_dir: float):
	if player.is_on_floor() and current_animation != "jumping":
		play(&"walking")
	# Added to make sure that we go to midair if we walk from a ledge
	elif !player.is_on_floor() and current_animation == "walking":
		play_midair_animation()

func play_idle_animation():
	if player.is_on_floor():
		play(&"idle")

func play_jump_animation():
	play(&"jumping")
	await animation_finished
	play_midair_animation()

func play_landing_animation():
	play(&"landing")
	# Cheap way to get around the signal 
	await animation_finished
	play_idle_animation()

func play_midair_animation():
	play(&"midair")
