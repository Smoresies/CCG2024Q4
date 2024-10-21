extends Node

@export var material: String
@onready var landing_sfx: AudioStreamPlayer2D = $"Landing SFX"
@onready var footstep_sfx: AudioStreamPlayer2D = $"Footstep SFX"
@onready var jumping_sfx: AudioStreamPlayer2D = $"Jumping SFX"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_sfx_material(material: String) -> void:
	footstep_sfx.get_stream_playback().switch_to_clip_by_name(material)
	jumping_sfx.get_stream_playback().switch_to_clip_by_name(material)
	landing_sfx.get_stream_playback().switch_to_clip_by_name(material)
