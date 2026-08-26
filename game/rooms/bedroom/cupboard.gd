extends FurnitureAbstract

var opened: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	pass # Replace with function body.

func open_padlock_window():
	pass

func close_doors():
	pass

func on_action_selected(action: String) -> void:
	if action == GlobalPlayer.ACTION_OPEN:
		if opened:
			player_say('Cupboard already opened')
			return
		open_padlock_window()
	elif action == GlobalPlayer.ACTION_CLOSE:
		if not opened:
			player_say('Cupboard already closed')
			return

		close_doors()
		
	elif action == GlobalPlayer.ACTION_OBSERVE:
		player_say("It is a cupboard, maybe something inside ?")
	else:
		player_say("I don't think so")
