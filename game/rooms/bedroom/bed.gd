extends FurnitureAbstract


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	pass # Replace with function body.

	
func on_action_selected(action: String) -> void:
	if action == GlobalPlayer.ACTION_OBSERVE:
		player_say("It is a simple bed")
	else:
		player_say("I don't think so")
