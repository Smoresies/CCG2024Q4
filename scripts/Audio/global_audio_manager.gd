extends Resource

@export var master_volume: int
@export var music_volume: int
@export var sfx_volume: int
@export var ambience_volume: int
var audio_output_device_list = []

# Called when the node enters the scene tree for the first time.
# Sets volume to a reasonable default with room to adjust up and down
# Sets up the audio device selector
func _ready() -> void:
	set_master_volume(8)
	set_music_volume(8)
	set_sfx_volume(8)
	# Get all devices 
	# For each device: 
		# Check if it's the active device
		# Select the active device 

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
	pass
	# TODO
