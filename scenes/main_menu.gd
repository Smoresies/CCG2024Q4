extends Control

@onready var button_hover_sfx: AudioStreamPlayer = $"Menu Audio Manager/Button Hover SFX"
@onready var general_button_sfx: AudioStreamPlayer = $"Menu Audio Manager/General Button SFX"
@onready var back_button_sfx: AudioStreamPlayer = $"Menu Audio Manager/Back Button SFX"
@onready var pause_sfx: AudioStreamPlayer = $"Menu Audio Manager/Pause SFX"
@onready var unpause_sfx: AudioStreamPlayer = $"Menu Audio Manager/Unpause SFX"
@onready var error_sfx: AudioStreamPlayer = $"Menu Audio Manager/Error SFX"
@onready var slider_adjusted_sfx: AudioStreamPlayer = $"Menu Audio Manager/Slider Adjusted SFX"


func _on_play_pressed() -> void:
	play_generic_button_press_sfx()

func _on_options_pressed() -> void:
	play_generic_button_press_sfx()
  #TODO: replace this with controls scene
	get_tree().change_scene_to_file("res://scenes/audio_menu.tscn")

func _on_credits_pressed() -> void:
	play_generic_button_press_sfx()


func _on_exit_pressed() -> void:
	play_back_button_sfx()
	await back_button_sfx.finished
	get_tree().quit()

func _on_play_mouse_entered() -> void:
	play_generic_hover_sfx()

func _on_options_mouse_entered() -> void:
	play_generic_hover_sfx()

func _on_credits_mouse_entered() -> void:
	play_generic_hover_sfx()

func _on_exit_mouse_entered() -> void:
	play_generic_hover_sfx()

# SFX-SPECIFIC METHODS BELOW #
## Play generic button sound effect.
func play_generic_button_press_sfx() -> void:
	general_button_sfx.play()

## Play navigate back sound. 
func play_back_button_sfx() -> void:
	back_button_sfx.play()

## Play error button sound. 
func play_error_button_sfx() -> void: 
	error_sfx.play()

## Play generic button hover sound. 
func play_generic_hover_sfx() -> void:
	button_hover_sfx.play()

## Play generic slider adjustment sound. 
func play_generic_slider_adjustment_sfx() -> void:
	slider_adjusted_sfx.play()
# END SFX-SPECIFIC METHODS #

func _on_test_slider_value_changed(value: float) -> void:
	play_generic_slider_adjustment_sfx()
