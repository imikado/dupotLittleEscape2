extends FurnitureAbstract

const ANIM_CLOSED = "closed"
const ANIM_OPENED = "opened"
const ANIM_OPENED_WITH_KEY = "opened_with_key"
const ANIM_OPEN = "open"
const ANIM_OPEN_WITH_KEY = "open_with_key"

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	set_id("cupboard")
	
	var anim:String=""
	if GlobalGame.has_pending_event(GlobalGame.ASYNC_EVENT_BEDROOM_CUPBOARD_OPEN):
		if has_item_state():
			anim=ANIM_OPEN_WITH_KEY
		else:	
			anim=ANIM_OPEN
	elif is_opened_state():
		if has_item_state():
			anim=ANIM_OPENED_WITH_KEY
		else:	
			anim=ANIM_OPENED
	else:
		anim=ANIM_CLOSED
		
	animationPlayer.play(anim)
		
	pass # Replace with function body.

func open_padlock_window():
	GlobalGame.open_window(GlobalGame.WINDOW_BEDROOM_CUPBOARD_PADLOCK)
	pass

func close_doors():
	animationPlayer.play_backwards("open")
	set_closed_state()
	pass

func on_action_selected(action: String) -> void:
	if action == GlobalPlayer.ACTION_OPEN:
		if is_opened_state():
			player_say('Cupboard already opened')
			return
		open_padlock_window()
	elif action == GlobalPlayer.ACTION_CLOSE:
		if not is_opened_state():
			player_say('Cupboard already closed')
			return

		close_doors()
		
	elif action == GlobalPlayer.ACTION_OBSERVE:
		player_say("It is a cupboard, maybe something inside ?")
	
	elif is_opened_state() and action==GlobalPlayer.ACTION_TAKE and has_item_state():
		GlobalPlayer.add_item_in_inventory(GlobalGame.ITEM_BEDROOM_KEY)
		remove_item_state()
		
		animationPlayer.play(ANIM_OPENED)
	
	else:
		player_say("I don't think so")

		
