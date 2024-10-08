extends Node

@export var master_volume: int
@export var music_volume: int
@export var sfx_volume: int
@export var ambience_volume: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_master_volume(8)
	set_music_volume(8)
	set_sfx_volume(8)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_master_volume(volume: int):
	pass
	
func set_music_volume(volume: int):
	pass
	
func set_sfx_volume(volume: int):
	pass
	
	
