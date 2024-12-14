extends Control


func _ready() -> void: 
	pass


func _on_play_pressed() -> void:
	pass # Replace with function body.
	

func _on_options_pressed() -> void:
	#TODO: replace this with controls scene
	get_tree().change_scene_to_file("res://scenes/audio_menu.tscn")

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()
