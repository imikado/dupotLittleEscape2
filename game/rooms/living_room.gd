extends RoomAbstract


const DEBUG = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	if DEBUG:
		#GlobalPlayer.add_item_in_inventory(GlobalGame.ITEM_BEDROOM_CLUE)
		pass
		
	if not GlobalPlayer.get_global_position() == Vector2.ZERO:
		pass
	elif GlobalGame.get_room_from()==GlobalGame.ROOM.BEDROOM:
		var default_position = Vector2(26, 204)
		_player.global_position = default_position
		_player.set_target_position(default_position)
 
	else:
		var default_position = Vector2(452, 192)
		_player.global_position = default_position
		_player.set_target_position(default_position)
