extends Control

var config = ConfigFile.new()
var config_file_path = "user://config.cfg"

@export var master_volume: float
@export var music_volume: float
@export var sfx_volume: float
@export var ambience_volume: float

@export var master_bus_index = AudioServer.get_bus_index("Master")
@export var music_bus_index = AudioServer.get_bus_index("Music")
@export var sfx_bus_index = AudioServer.get_bus_index("SFX")
@export var ambience_bus_index = AudioServer.get_bus_index("Ambience")

# Reference volume sliders
@onready var master_volume_slider: HSlider = $"Audio Menu Constraints/Audio Settings/Master Volume/Master Volume Slider"
@onready var music_volume_slider: HSlider = $"Audio Menu Constraints/Audio Settings/Music Volume/Music Volume Slider"
@onready var sfx_volume_slider: HSlider = $"Audio Menu Constraints/Audio Settings/SFX Volume/SFX Volume Slider"
@onready var ambience_volume_slider: HSlider = $"Audio Menu Constraints/Audio Settings/Ambience Volume/Ambience Volume Slider"

# Reference the output device OptionButton
@onready var output_device_selector: OptionButton = $"Audio Menu Constraints/Audio Settings/Output Device/Output Device Selector"

## Sets the audio buses to a default value. Recalls settings from a saved config file.
func _ready() -> void:
	set_master_volume(0.7)
	set_music_volume(0.7)
	set_sfx_volume(0.7)
	set_ambience_volume(0.7)
	
	initialize_audio_device_selector()
	read_config_file()

## Sets up the audio device selector. Separated into its own function to avoid merge conflicts. 
func initialize_audio_device_selector():
	# For each output device: Add it to the list
	for device in AudioServer.get_output_device_list():
		output_device_selector.add_item(device)

	# For each item in the list: 
	for i in range(output_device_selector.item_count):
		# Check: is it the active device
		var device = output_device_selector.get_item_text(i) 
		if device == AudioServer.output_device:
			# If it is, select the device. 
			output_device_selector.select(i) 
			break

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
	
	# Set the audio settings according to recall results
	set_master_volume(master_volume)
	set_music_volume(music_volume)
	set_sfx_volume(sfx_volume)
	set_ambience_volume(ambience_volume)

## DEBUG: print audio bus volumes
func print_audio_settings() -> void:
	print("Master vol: \t" + str(master_volume) + "\n")
	print("Music vol: \t\t" + str(music_volume))
	print("SFX vol: \t\t" + str(sfx_volume))
	print("Ambience vol: \t" + str(ambience_volume))

## When a device is selected from the menu, set the output device appropriately. 
func _on_output_device_selector_item_selected(index: int): 
	# Find device at index
	var device = output_device_selector.get_item_text(index)
	# Set to active output device
	AudioServer.output_device = device 

## Update the master bus volume, update the settings slider value, and save settings
func set_master_volume(new_volume: float):
	master_volume = new_volume
	var volume = linear_to_db(new_volume)
	AudioServer.set_bus_volume_db(master_bus_index, volume)
	master_volume_slider.value = master_volume
	on_audio_settings_changed()

## Update the music bus volume, update the settings slider value, and save settings
func set_music_volume(new_volume: float):
	music_volume = new_volume
	var volume = linear_to_db(new_volume)
	AudioServer.set_bus_volume_db(music_bus_index, volume)
	music_volume_slider.value = music_volume
	on_audio_settings_changed()

## Update the SFX bus volume, update the settings slider value, and save settings
func set_sfx_volume(new_volume: float):
	sfx_volume = new_volume
	var volume = linear_to_db(new_volume)
	AudioServer.set_bus_volume_db(sfx_bus_index, volume)
	sfx_volume_slider.value = sfx_volume
	on_audio_settings_changed()

## Update the ambience bus volume, update the settings slider value, and save settings
func set_ambience_volume(new_volume: float):
	ambience_volume = new_volume
	var volume = linear_to_db(new_volume)
	AudioServer.set_bus_volume_db(ambience_bus_index, volume)
	ambience_volume_slider.value = ambience_volume
	on_audio_settings_changed()

func on_audio_settings_changed() -> void: 
	save_audio_settings()
	print_audio_settings() # DEBUG: reports audio settings via console


func _on_master_volume_slider_value_changed(value: float) -> void:
	set_master_volume(value)

func _on_music_volume_slider_value_changed(value: float) -> void:
	set_music_volume(value)

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	set_sfx_volume(value)

func _on_ambience_volume_slider_value_changed(value: float) -> void:
	set_ambience_volume(value)
