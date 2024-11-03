class_name Utilities extends RefCounted

static func make_abstract_class(name: String) -> void:
	push_error('Abstract Class Instaniation Error: %s' % name)
	assert (false, 'Abstract Class Instaniation Error: %s' % name)

static func make_abstract_function(name: String) -> void:
	push_error('Abstract Method Not Implemented Error: %s' % name)
	assert (false, 'Abstract Method Not Implemented Error: %s' % name)
