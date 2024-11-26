extends Node

@onready var projectile_sfx: AudioStreamPlayer2D = $"Projectile SFX"

# An array containing supported projectile SFX types. 
@export var projectile_sfx_types: Array = [&"basic pellet"]
var default_projectile_sfx: String = projectile_sfx_types[0]
var current_projectile_sfx: String = default_projectile_sfx

## Change the active sound effect to a given weapon type. If an invalid input is passed in, sets to the default weapon type. 
func update_projectile_SFX(new_projectile_type) -> void:
	if new_projectile_type in projectile_sfx_types:
		current_projectile_sfx = new_projectile_type
	else:
		current_projectile_sfx = default_projectile_sfx
	
	# Apply the new weapon SFX type to AudioStreamPlayer node.
	if projectile_sfx.has_stream_playback():
		projectile_sfx.get_stream_playback().switch_to_clip_by_name(current_projectile_sfx)
	

## Changes the active audio clip attached to a projectile to reflect its destruction.  
func _on_projectile_destroyed() -> void:
	pass
	# TODO trigger clip change 
	# TODO await finished signal
