extends Node

@onready var landing_sfx: AudioStreamPlayer2D = $"Landing SFX"
@onready var footstep_sfx: AudioStreamPlayer2D = $"Footstep SFX"
@onready var jumping_sfx: AudioStreamPlayer2D = $"Jumping SFX"
@onready var moth_jump_sfx: AudioStreamPlayer2D = $"Moth Jump SFX"
# An array containing the valid surface types for sound effects. 
@export var sfx_floor_materials: Array = ["dirt", "wood"]
# The first item in the array is the default value. 
@export var default_sfx_floor_material: String = sfx_floor_materials[0]
@export var current_sfx_material: String = default_sfx_floor_material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if set_sfx_floor_material(default_sfx_floor_material) < 0:
		print("No stream playback found")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Set the floor material beneath the player for triggering SFX. 
# Invalid inputs will reset material to default_sfx_floor_material.
# If the floor material has no stream playback, returns -1. 
func set_sfx_floor_material(sfx_material: String) -> int:
	if !(footstep_sfx.has_stream_playback() && jumping_sfx.has_stream_playback() && landing_sfx.has_stream_playback()):
		return -1
		
	# If the input is valid, accept the new material
	if sfx_material in sfx_floor_materials:
		current_sfx_material = sfx_material
	# Reset to the default clip. 
	else: 
		current_sfx_material = default_sfx_floor_material
		
	# Apply the new/default SFX material to relevant SFX player nodes. 
	footstep_sfx.get_stream_playback().switch_to_clip_by_name(current_sfx_material)
	jumping_sfx.get_stream_playback().switch_to_clip_by_name(current_sfx_material)
	landing_sfx.get_stream_playback().switch_to_clip_by_name(current_sfx_material)
	return 1

# When the moth jump is released, 
func _on_moth_jump_released() -> void:
	moth_jump_sfx.get_stream_playback().switch_to_clip_by_name("Player Moth-jump Release")
