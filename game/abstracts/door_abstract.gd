extends FurnitureAbstract
class_name DoorAbstract


@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

@export var roomTarget: GlobalGame.ROOM
@export var roomFrom: GlobalGame.ROOM
@export var isTarget: bool

@export var expectedKey: GlobalGame.ITEM

const ANIM_OPEN = "open"
const ANIM_CLOSED = "closed"
const ANIM_OPENED = "opened"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

	var roomId: GlobalGame.ROOM
	if isTarget:
		roomId = roomTarget
	else:
		roomId = roomFrom
	set_id(str(roomId))

	if is_opened_state():
		animationPlayer.play(ANIM_OPENED)
	else:
		animationPlayer.play(ANIM_CLOSED)


func is_not_clickable() -> bool:
	return false


func open_door():
	if is_opened_state():
		player_say("Already opened")
		return
	
	if GlobalPlayer.has_item_in_inventory(expectedKey):
		animationPlayer.play(ANIM_OPEN)
		set_opened_state()
	
	else:
		player_say("The door need a key")
	
func close_door():
	if not is_opened_state():
		player_say("Already closed")
		return

	set_closed_state()

func on_action_selected(action: String):
	if action == GlobalPlayer.ACTION_OPEN:
		return open_door()
	elif action == GlobalPlayer.ACTION_CLOSE:
		return close_door()
	elif action == GlobalPlayer.ACTION_WALK:
		if not is_opened_state():
			player_say("The door need a key")
			return
		else:
			GlobalGame.open_room_from_room(roomTarget, roomFrom)
			return
	player_say("I don't think so")
	
func get_current_room() -> GlobalGame.ROOM:
	if isTarget:
		return roomFrom
	return roomTarget
	#return GlobalGame.ROOM.DOOR
