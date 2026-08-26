extends FurnitureAbstract


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	pass # Replace with function body.

	
func on_action_selected(action: String) -> void:
	if action == GlobalPlayer.ACTION_OBSERVE:
		GlobalEvents.player_say.emit("It is a simple bed")
	else:
		GlobalEvents.player_say.emit("I don't think so")
