extends Node

@export var landing_sfx: AudioStreamPlayer2D
@export var footstep_sfx: AudioStreamPlayer2D
@export var jumping_sfx: AudioStreamPlayer2D
@export var moth_jump_sfx: AudioStreamPlayer2D
@onready var weapon_firing_sfx: AudioStreamPlayer2D = $"Weapon Firing SFX"

# An array containing the valid surface types for sound effects. 
@export var sfx_floor_materials: Array = [&"dirt", &"wood"]
# The first item in the array is the default value.
# Changed to be permanent until crashing errors are solved
var default_sfx_floor_material: StringName = sfx_floor_materials[0]
var current_sfx_material: String = default_sfx_floor_material

# An array containing supported weapon SFX types. 
@export var weapon_sfx_types: Array = [&"basic pellet"]
var default_weapon_sfx: String = weapon_sfx_types[0]
var current_weapon_sfx: String = default_weapon_sfx

# Set the floor material beneath the player for triggering SFX. 
# Invalid inputs will reset material to default_sfx_floor_material
func set_sfx_floor_material(sfx_material: String) -> void:
	# If the input is valid, accept the new material
	if sfx_material in sfx_floor_materials:
		current_sfx_material = sfx_material
	# Reset to the default clip. 
	else: 
		current_sfx_material = default_sfx_floor_material
		
	# Apply the new/default SFX material to relevant SFX player nodes. 
	if footstep_sfx.has_stream_playback():
		footstep_sfx.get_stream_playback().switch_to_clip_by_name(current_sfx_material)
	if jumping_sfx.has_stream_playback():
		jumping_sfx.get_stream_playback().switch_to_clip_by_name(current_sfx_material)
	if landing_sfx.has_stream_playback():
		landing_sfx.get_stream_playback().switch_to_clip_by_name(current_sfx_material)

## When the moth jump is released, 
func _on_moth_jump_released() -> void:
	moth_jump_sfx.get_stream_playback().switch_to_clip_by_name("Player Moth-jump Release")

## Update sound effects that play related to weapons
func set_weapon_sfx_type(weapon_sfx: String) -> void:
	if weapon_sfx in weapon_sfx_types:
		current_weapon_sfx = weapon_sfx
	else:
		current_weapon_sfx = default_weapon_sfx
	
	# Apply the new weapon SFX type to AudioStreamPlayer node.
	if weapon_firing_sfx.has_stream_playback():
		weapon_firing_sfx.get_stream_playback().switch_to_clip_by_name(current_weapon_sfx)
	# TODO: check and update projectile travel and destroy SFX with new weapon SFX 
