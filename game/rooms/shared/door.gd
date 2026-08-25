extends FurnitureAbstract

var opened:bool=false

@onready var animationPlayer:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	pass # Replace with function body.

func open_door():
	if opened:
		GlobalEvents.player_say.emit("Already opened")
		return
	
	if GlobalPlayer.has_item_in_inventory(GlobalPlayer.ITEM_BEDROOM_KEY):
		print('open door')
		animationPlayer.play("open")
		
	pass
	
func close_door():
	if not opened:
		GlobalEvents.player_say.emit("Already closed")
		return
	pass

func on_action_selected(action:String):
	if action==GlobalPlayer.ACTION_OPEN:
		return open_door()
	elif action==GlobalPlayer.ACTION_CLOSE:
		return close_door()
	GlobalEvents.player_say.emit("I don't think so")
