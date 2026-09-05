extends Node


enum ROOM {
	NONE,
	DOOR,
	BEDROOM,
	LIVINGROOM,
	BATHROOM
	}

#bedroom
enum ITEM {
	BEDROOM_KEY,
	BEDROOM_CLUE,
	BEDROOM_CLUE_CLOCK
	}

enum WINDOW {
	BEDROOM_CUPBOARD_PADLOCK
}

const STATE_BEDROOM_CUPBOARD = "bedroom_cupboard"
const STATE_LOCKED = "locked"

const ASYNC_EVENT_BEDROOM_CUPBOARD_OPEN = "bedroom_cupboard_open"

var _current_room: ROOM

var _state_value_list: Dictionary = {}

var _pending_event: String = ""

var _from_room: ROOM

var _room_dict = {
	ROOM.BEDROOM: "res://game/rooms/bedroom.tscn",
	ROOM.LIVINGROOM: "res://game/rooms/living_room.tscn",
	ROOM.BATHROOM: ""
}

var _item_dict = {
	ITEM.BEDROOM_KEY: [
		"res://game/rooms/bedroom/items/bedroomKey.png",
		"res://game/rooms/bedroom/items/bedroomKey.png"
	],
	ITEM.BEDROOM_CLUE: [
		"res://game/rooms/bedroom/items/bedsideTableClue.png",
		"res://game/rooms/bedroom/items/bedsideTableClueLarge.png"
	],
	ITEM.BEDROOM_CLUE_CLOCK: [
		"res://game/rooms/bedroom/items/bedsideTableClue2.png",
		"res://game/rooms/bedroom/items/bedsideTableClue2Large.png"
	]
}

var _item_show_path: String = ""

var _window_dict = {
	WINDOW.BEDROOM_CUPBOARD_PADLOCK: "res://game/rooms/bedroom/window/cupboard_pad_lock_window.tscn"
}

func set_room_from(room: ROOM):
	_from_room = room

func get_room_from() -> ROOM:
	return _from_room

func get_current_room() -> ROOM:
	return _current_room

func get_state_key(room: ROOM, item: String) -> String:
	return str(room) + '__' + item
	
func set_state_value(room: ROOM, item: String, value):
	_state_value_list.set(get_state_key(room, item), value)
	
func has_state_value(room: ROOM, item: String) -> bool:
	return _state_value_list.has(get_state_key(room, item))

func get_state_value(room: ROOM, item: String):
	return _state_value_list.get(get_state_key(room, item))


func open_room(room: ROOM, reset_position: bool = true):
	_current_room = room
	if reset_position:
		GlobalPlayer.set_global_position(Vector2.ZERO)
	get_tree().change_scene_to_file.call_deferred(_room_dict[room])

func go_to_previous_room():
	open_room(_current_room, false)

func open_room_from_room(room: ROOM, roomFrom: ROOM):
	set_room_from(roomFrom)
	open_room(room)


func open_window(window: WINDOW):
	get_tree().change_scene_to_file(_window_dict[window])

func get_item_icon_path(item_id: GlobalGame.ITEM) -> String:
	return _item_dict[item_id][0]

func get_item_large_path(item_id: GlobalGame.ITEM) -> String:
	return _item_dict[item_id][1]

func open_item_show_with_name(item_id: GlobalGame.ITEM):
	_item_show_path = get_item_large_path(item_id)
	get_tree().change_scene_to_file("res://game/shared/item_show.tscn")
	
func get_item_show_path() -> String:
	return _item_show_path

func has_pending_event(event: String) -> bool:
	if _pending_event == event:
		_pending_event = ""
		return true
	return false

func set_pending_event(event: String):
	_pending_event = event
