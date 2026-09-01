extends FurnitureAbstract

var opened: bool = false

@onready var animationPlayer: AnimationPlayer=$AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	pass # Replace with function body.

func start_blinking():
	if not _control or (not GlobalPlayer.is_current_action_selectable() and not is_opened_state()):
		return
	#stop_blinking()
	_control.mouse_default_cursor_shape=Control.CURSOR_POINTING_HAND
				
	selection_tween = create_tween().set_loops()
	
	selection_tween.tween_property(_sprite, "modulate", Color.GRAY, 0.6)
	selection_tween.tween_property(_sprite, "modulate", Color.WHITE, 0.3)

func open_door():
	if opened:
		player_say("Already opened")
		return
	
	if GlobalPlayer.has_item_in_inventory(GlobalGame.ITEM_BEDROOM_KEY):
		print('open door')
		animationPlayer.play("open")
	
	else:
		player_say("The door need a key")
	
func close_door():
	if not opened:
		player_say("Already closed")
		return
	pass

func on_action_selected(action: String):
	if action == GlobalPlayer.ACTION_OPEN:
		return open_door()
	elif action == GlobalPlayer.ACTION_CLOSE:
		return close_door()
	player_say("I don't think so")
