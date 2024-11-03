extends DialogicNode_Input


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Chatter Script Exists")
	Dialogic.Inputs.auto_advance.enabled_forced = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_dialogic_node_dialog_text_finished_revealing_text():
	print("Done Revealing")
	Dialogic.Inputs.auto_advance.enabled_until_next_event = true
