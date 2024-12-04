extends Node

@export var master_volume: int
@export var music_volume: int
@export var sfx_volume: int
@export var ambience_volume: int
# TODO: remove array and selected_device variables, deprecated implementation
#var audio_output_device_list = []
#var selected_device
# TODO: link the following line with the OptionButton in the user interface
@onready var output_device_options: OptionButton = $"Output Device Options"

# Called when the node enters the scene tree for the first time.
# Sets volume to a reasonable default with room to adjust up and down
# Sets up the audio device selector
func _ready() -> void:
	set_master_volume(8)
	set_music_volume(8)
	set_sfx_volume(8)
	initialize_audio_device_selector()

# Sets up the audio device selector. Separated into its own function to avoid merge conflicts. 
func initialize_audio_device_selector():
	# For each output device: 
	for device in AudioServer.get_output_device_list():
		# Add it to the list
		#audio_output_device_list.append(device) # TODO: remove array implementation. Uncomment OptionButton implementation. 
		output_device_options.add_item(device)

	# For each item in the list: 
	#for i in range(audio_output_device_list.size()):
	for i in range(output_device_options.item_count):
		# Check: is it the active device
		#var device = audio_output_device_list[i] # TODO: remove array implementation, uncomment OptionButton implementation.
		var device = output_device_options.get_item_text(i) 
		if device == AudioServer.output_device:
			# If it is, select the device. 
			#selected_device = audio_output_device_list[i] # TODO: remove array implementation. Uncomment OptionButton implementation. 
			output_device_options.select(i) # OptionButton implementation
			break
	# TODO: Remove the print lines. Deprecated array implementation. 
	#print("Audio output device list: " + str(audio_output_device_list))
	#print("Active audio device: " + selected_device)

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
	#selected_device = audio_output_device_list[index] # TODO: delete array impelemtation
	var device = output_device_options.get_item_text(index) # OptionButton implementation
	# Set to active output device
	AudioServer.output_device = device # OptionButton implementation
	#AudioServer.output_device = selected_device # TODO: delete array implementation
	
