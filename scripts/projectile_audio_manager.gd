extends Node

@onready var projectile_travel_sfx: AudioStreamPlayer2D = $"Projectile Travel SFX"
@onready var projectile_destroy_sfx: AudioStreamPlayer2D = $"Projectile Destroy SFX"
@onready var projectile: BaseProjectileComponent = $".."

# An array containing supported projectile SFX types. 
@export var projectile_sfx_types: Array = ["basic pellet"]
var default_projectile_sfx: String = projectile_sfx_types[0]
var current_projectile_sfx: String = default_projectile_sfx

func _ready() -> void:
	set_projectile_SFX(projectile.projectile_sfx)
	projectile_travel_sfx.play()

## Change the active sound effect to a given weapon type. If an invalid input is passed in, sets to the default weapon type. 
func set_projectile_SFX(new_projectile_sfx) -> void:
	if new_projectile_sfx in projectile_sfx_types:
		current_projectile_sfx = new_projectile_sfx
	else:
		current_projectile_sfx = default_projectile_sfx
	
	# Apply the new weapon SFX type to AudioStreamPlayer node.
	if projectile_travel_sfx.has_stream_playback() and projectile_destroy_sfx.has_stream_playback():
		projectile_travel_sfx.get_stream_playback().switch_to_clip_by_name(current_projectile_sfx)
		projectile_destroy_sfx.get_stream_playback().switch_to_clip_by_name(current_projectile_sfx)

## Changes the active audio clip attached to a projectile to reflect its destruction.  
func _on_projectile_on_destroy() -> void:
	projectile_travel_sfx.stop()
	projectile_destroy_sfx.play()
	# TODO learn where to place this to allow SFX to complete
	await projectile_destroy_sfx.finished
