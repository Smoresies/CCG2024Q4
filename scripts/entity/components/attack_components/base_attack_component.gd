class_name BaseAttackComponent extends Node

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_started()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack()

@warning_ignore("UNUSED_SIGNAL")
signal on_attack_cancelled()

func _ready() -> void:
	# Abstract class instantiation error
	push_error('Abstract Class Instantiation Error: %s' % [name])
	assert(false, 'Abstract Class Instantiation Error: %s' % [name])

func on_attack_input_started() -> void:
	# Abstract method error
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert(false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_attack_input() -> void:
	# Abstract method error
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert(false, 'Abstract Method Not Implemented Error: %s' % [name])

func on_attack_input_cancelled() -> void:
	# Abstract method error
	push_error('Abstract Method Not Implemented Error: %s' % [name])
	assert(false, 'Abstract Method Not Implemented Error: %s' % [name])
