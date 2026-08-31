extends FurnitureAbstract

func on_action_selected(action: String) -> void:
	if action == GlobalPlayer.ACTION_OBSERVE:
		player_say("On this clock it is 15:30")
	else:
		player_say("I don't think so")
	
