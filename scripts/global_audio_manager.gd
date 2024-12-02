extends Control

var config = ConfigFile.new()
var config_file_path = "user://Saves/config.cfg"

@export var master_volume: float
@export var music_volume: float
@export var sfx_volume: float
@export var ambience_volume: float

@export var master_bus_index = AudioServer.get_bus_index("Master")
@export var music_bus_index = AudioServer.get_bus_index("Music")
@export var sfx_bus_index = AudioServer.get_bus_index("SFX")
@export var ambience_bus_index = AudioServer.get_bus_index("Ambience")

## Sets the audio buses to a reasonable loudness. Recalls settings from a saved config file. 
func _ready() -> void:
	set_master_volume(0.7)
	set_music_volume(0.7)
	set_sfx_volume(0.7)
	set_ambience_volume(0.7)
	
	read_config_file()

func save_audio_settings() -> void:
	# Set values based on the user's preferences:
	config.set_value("AudioSettings","master_volume",master_volume)
	config.set_value("AudioSettings","music_volume",music_volume)
	config.set_value("AudioSettings","sfx_volume",sfx_volume)
	config.set_value("AudioSettings","ambience_volume",ambience_volume)
	
	# Save to a file (or overwrite an existing file)
	config.save(config_file_path)

func read_config_file() -> void:
	# Load data from the file
	var err = config.load(config_file_path)
	
	# If the file didn't load, send a message and ignore it
	if err != OK:
		print("The file \"" + config_file_path + "\" could not be loaded.")
		return
	
	# Parse the audio section and recall the stored volume settings. 
	master_volume = config.get_value("AudioSettings","master_volume")
	music_volume = config.get_value("AudioSettings","music_volume")
	sfx_volume = config.get_value("AudioSettings","sfx_volume")
	ambience_volume = config.get_value("AudioSettings","ambience_volume")
	

func print_audio_settings() -> void:
	# For verification purposes: 
	print("Master vol: \t" + str(master_volume) + "\n")
	#print("Music vol: \t\t" + str(music_volume))
	#print("SFX vol: \t\t" + str(sfx_volume))
	#print("Ambience vol: \t" + str(ambience_volume))
	

func set_master_volume(new_volume: float):
	master_volume = new_volume
	var volume = linear_to_db(new_volume)
	AudioServer.set_bus_volume_db(master_bus_index, volume)
	on_audio_settings_changed()
	

# TODO
func set_music_volume(volume: float):
	on_audio_settings_changed()
	

# TODO
func set_sfx_volume(volume: float):
	on_audio_settings_changed()

# TODO
func set_ambience_volume(volume: float):
	on_audio_settings_changed()
	

func on_audio_settings_changed() -> void: 
	# TEMP for debugging TODO: un-comment
	#save_audio_settings()
	print_audio_settings()


func _on_save_pressed() -> void:
	save_audio_settings()

func _on_load_pressed() -> void:
	read_config_file()

func _on_master_volume_slider_value_changed(value: float) -> void:
	set_master_volume(value)
