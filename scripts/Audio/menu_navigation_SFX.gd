extends MarginContainer

# Reference SFX
@onready var general_button_hover: AudioStreamPlayer = $"Menu Nav SFX/General Button Hover SFX"
@onready var general_button_press: AudioStreamPlayer = $"Menu Nav SFX/General Button Press SFX"
@onready var back_button_press: AudioStreamPlayer = $"Menu Nav SFX/Back Button Press SFX"
@onready var error_button_press: AudioStreamPlayer = $"Menu Nav SFX/Error Button Press SFX"
@onready var slider_adjustment_sfx: AudioStreamPlayer = $"Menu Nav SFX/Slider Adjustment SFX"
@onready var game_paused_sfx: AudioStreamPlayer = $"Menu Nav SFX/Game Paused SFX"
@onready var game_unpaused_sfx: AudioStreamPlayer = $"Menu Nav SFX/Game Unpaused SFX"

# Reference buttons
@onready var to_controls: Button = $"Navigation Options/To Controls"
@onready var to_sound: Button = $"Navigation Options/To Sound"
@onready var back: Button = $"Navigation Options/Back"
@onready var output_device_selector: OptionButton = $"../Audio Menu Constraints/Audio Settings/Output Device/Output Device Selector"

# Reference sliders
@onready var master_volume_slider: HSlider = $"../Audio Menu Constraints/Audio Settings/Master Volume/Master Volume Slider"
@onready var music_volume_slider: HSlider = $"../Audio Menu Constraints/Audio Settings/Music Volume/Music Volume Slider"
@onready var sfx_volume_slider: HSlider = $"../Audio Menu Constraints/Audio Settings/SFX Volume/SFX Volume Slider"
@onready var ambience_volume_slider: HSlider = $"../Audio Menu Constraints/Audio Settings/Ambience Volume/Ambience Volume Slider"


#========= SFX CALLS =========#
func play_general_button_press_sfx() -> void: 
	general_button_press.play()

func play_general_button_hover_sfx() -> void:
	general_button_hover.play()

func play_back_button_sfx() -> void:
	back_button_press.play()

func play_general_slider_adjustment_sfx() -> void: 
	slider_adjustment_sfx.play()

func play_error_button_press_sfx() -> void: 
	error_button_press.play()


#========= BUTTON PRESSES =========#
func _on_to_controls_pressed() -> void:
	play_general_button_press_sfx()
	to_controls.disabled = true
	await general_button_press.finished
	#TODO: replace with controls scene location
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_to_sound_pressed() -> void:
	play_error_button_press_sfx()

func _on_back_pressed() -> void:
	play_back_button_sfx()
	back.disabled = true
	await back_button_press.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_output_device_selector_toggled(toggled_on: bool) -> void:
	if toggled_on:
		play_general_button_press_sfx()
	else: 
		play_back_button_sfx()

func _on_output_device_selector_item_selected(index: int) -> void:
	play_general_button_press_sfx()



#========= BUTTON HOVERS =========#
func _on_to_controls_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_to_sound_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_back_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_output_device_selector_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_master_volume_slider_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_music_volume_slider_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_sfx_volume_slider_mouse_entered() -> void:
	play_general_button_hover_sfx()

func _on_ambience_volume_slider_mouse_entered() -> void:
	play_general_button_hover_sfx()



#========= SLIDER ADJUSTMENT =========#
func _on_master_volume_slider_drag_started() -> void:
	play_general_slider_adjustment_sfx()

func _on_master_volume_slider_drag_ended(value_changed: bool) -> void:
	play_back_button_sfx()

func _on_music_volume_slider_drag_started() -> void:
	play_general_slider_adjustment_sfx()

func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	play_back_button_sfx()

func _on_sfx_volume_slider_drag_started() -> void:
	play_general_slider_adjustment_sfx()

func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	play_back_button_sfx()

func _on_ambience_volume_slider_drag_started() -> void:
	play_general_slider_adjustment_sfx()

func _on_ambience_volume_slider_drag_ended(value_changed: bool) -> void:
	play_back_button_sfx()
