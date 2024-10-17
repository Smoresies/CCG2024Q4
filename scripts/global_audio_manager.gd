extends Resource

@export var master_volume: float
@export var music_volume: float
@export var sfx_volume: float
@export var ambience_volume: float
@export var SFX_BUS_ID: int
@export var MUSIC_BUS_ID: int
@export var AMBIENCE_BUS_ID: int

# Sets volume to a reasonable default with room to adjust up and down
func _init() -> void:
	set_master_volume(0.7)
	set_music_volume(0.7)
	set_sfx_volume(0.7)
	
	SFX_BUS_ID = AudioServer.get_bus_index("SFX")
	MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
	AMBIENCE_BUS_ID = AudioServer.get_bus_index("Ambience")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Update bus volume according to settings slider. Mutes the bus when volume is at 0. 
# TODO: create a master volume slider, 0-1, initial 0.7, step 0.02
# TODO: reference this method in _on_master_slider_value_changed()
func set_master_volume(volume: float):
	AudioServer.set_bus_volume_db(0, linear_to_db(volume))
	AudioServer.set_bus_mute(0, volume < 0.05)

# Update bus volume according to settings slider. Mutes the bus when volume is at 0. 
# TODO: create a music volume slider, 0-1, initial 0.7, step 0.02
# TODO: reference this method in _on_music_slider_value_changed()
func set_music_volume(volume: float):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(volume))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, volume < 0.02)

# Update bus volume according to settings slider. Mutes the bus when volume is at 0. 
# TODO: create an SFX volume slider, 0-1, initial 0.7, step 0.02
# TODO: reference this method in _on_sfx_slider_value_changed()
func set_sfx_volume(volume: float):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(volume))
	AudioServer.set_bus_mute(SFX_BUS_ID, volume < 0.02)

# Update bus volume according to settings slider. Mutes the bus when volume is at 0. 
# TODO: create an ambience volume slider, 0-1, initial 0.7, step 0.02
# TODO: reference this method in _on_ambience_slider_value_changed()
func set_ambience_volume(volume: float):
	AudioServer.set_bus_volume_db(AMBIENCE_BUS_ID, linear_to_db(volume))
	AudioServer.set_bus_mute(AMBIENCE_BUS_ID, volume < 0.02)
