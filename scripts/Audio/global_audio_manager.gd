extends Node

@export var master_volume: int
@export var music_volume: int
@export var sfx_volume: int
@export var ambience_volume: int
# TODO: link the following line with the OptionButton in the user interface
@onready var output_device_options: OptionButton = $"Output Device Options"

## Sets volume to a reasonable default with room to adjust up and down. Sets up the audio device selector
func _ready() -> void:
	set_master_volume(8)
	set_music_volume(8)
	set_sfx_volume(8)
	initialize_audio_device_selector()

## Sets up the audio device selector. Separated into its own function to avoid merge conflicts. 
func initialize_audio_device_selector():
	# For each output device: Add it to the list
	for device in AudioServer.get_output_device_list():
		output_device_options.add_item(device)

	# For each item in the list: 
	for i in range(output_device_options.item_count):
		# Check: is it the active device
		var device = output_device_options.get_item_text(i) 
		if device == AudioServer.output_device:
			# If it is, select the device. 
			output_device_options.select(i) 
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# TODO
func set_master_volume(volume: int):
	pass

# TODO
func set_music_volume(volume: int):
	pass

# TODO
func set_sfx_volume(volume: int):
	pass

## TODO: Connect this function to the signal for selecting an item from the output device dropdown menu
func _on_output_device_options_item_selected(index: int): 
	# Find device at index
	var device = output_device_options.get_item_text(index)
	# Set to active output device
	AudioServer.output_device = device 
	
