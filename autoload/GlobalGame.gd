extends Node

#bedroom
const ROOM_BEDROOM = "room_bedroom"

const ITEM_BEDROOM_KEY = "item_bedroom_key"
const ITEM_BEDROOM_CLUE = "item_bedroom_clue"
const ITEM_BEDROOM_CLUE_CLOCK = "item_bedroom_clue_clock"

const WINDOW_BEDROOM_CUPBOARD_PADLOCK="window_bedroom_cupboard_padlock"

const STATE_BEDROOM_CUPBOARD="bedroom_cupboard"
const STATE_LOCKED="locked"

const ASYNC_EVENT_BEDROOM_CUPBOARD_OPEN="bedroom_cupboard_open"

var _current_room: String

var _state_value_list: Dictionary = {}

var _pending_event:String=""

var _room_dict = {
	ROOM_BEDROOM: "res://game/rooms/bedroom.tscn"
}

var _item_dict = {
	ITEM_BEDROOM_KEY: [
		"res://game/rooms/bedroom/items/bedroomKey.png",
		"res://game/rooms/bedroom/items/bedroomKey.png"
	],
	ITEM_BEDROOM_CLUE: [
		"res://game/rooms/bedroom/items/bedsideTableClue.png",
		"res://game/rooms/bedroom/items/bedsideTableClueLarge.png"
	],
	ITEM_BEDROOM_CLUE_CLOCK: [
		"res://game/rooms/bedroom/items/bedsideTableClue2.png",
		"res://game/rooms/bedroom/items/bedsideTableClue2Large.png"
	]
}

var _item_show_path: String = ""

var _window_dict={
	WINDOW_BEDROOM_CUPBOARD_PADLOCK:"res://game/rooms/bedroom/window/cupboard_pad_lock_window.tscn"
}

func get_current_room() -> String:
	return _current_room

func get_state_key(room: String, item: String) -> String:
	return room + '__' + item
	
func set_state_value(room: String, item: String, value):
	_state_value_list.set(get_state_key(room, item), value)
	
func has_state_value(room: String, item: String) -> bool:
	return _state_value_list.has(get_state_key(room, item))

func get_state_value(room: String, item: String):
	return _state_value_list.get(get_state_key(room, item))


func open_room(room: String):
	_current_room = room
	get_tree().change_scene_to_file(_room_dict[room])

func go_to_previous_room():
	open_room(_current_room)

func open_window(window:String):
	get_tree().change_scene_to_file(_window_dict[window])

func get_item_icon_path(item_id: String) -> String:
	return _item_dict[item_id][0]

func get_item_large_path(item_id: String) -> String:
	return _item_dict[item_id][1]

func open_item_show_with_name(item_id: String):
	_item_show_path = get_item_large_path(item_id)
	get_tree().change_scene_to_file("res://game/shared/item_show.tscn")
	
func get_item_show_path() -> String:
	return _item_show_path

func has_pending_event(event:String)->bool:
	if _pending_event==event:
		_pending_event=""
		return true
	return false

func set_pending_event(event:String):
	_pending_event=event
