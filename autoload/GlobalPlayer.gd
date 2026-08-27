extends Node

const ACTION_OPEN="action_open"
const ACTION_CLOSE="action_close"
const ACTION_OBSERVE="action_observe"
const ACTION_USE="action_use"
const ACTION_TAKE="action_take"
const ACTION_WALK="action_walk"

const ITEM_BEDROOM_KEY="item_bedroom_key"
const ITEM_BEDROOM_CLUE="item_bedroom_clue"

const ROOM_BEDROOM="room_bedroom"

var _room_selected:String

var _room_dictionary={
	ROOM_BEDROOM:"res://game/rooms/bedroom.tscn"
}

var _itemDictionary={
	ITEM_BEDROOM_CLUE:"res://game/rooms/bedroom/items/bedsideTableClueLarge.png"
}

var _inventory_list:Array[String]=[]

var _global_position:Vector2=Vector2.ZERO
var _state_value_list:Dictionary={}

var _action_selected:String=""

var _item_show_path:String=""

func start_action(action:String):
	_action_selected=action

func stop_action():
	_action_selected=""
	GlobalEvents.stop_action.emit()
	
func get_current_action():
	return _action_selected
	
func has_current_action()->bool:
	return _action_selected !=''

func is_current_action_walkable()->bool:
	return _action_selected==ACTION_WALK

func is_current_action_selectable()->bool:
	return _action_selected!=ACTION_WALK and _action_selected!=''

func add_item_in_inventory(item:String):
	_inventory_list.append(item)
	GlobalEvents.refresh_inventory.emit()
	
func has_item_in_inventory(item:String)->bool:
	return _inventory_list.has(item)

func get_item_list_in_inventory()->Array[String]:
	return _inventory_list

func set_global_position(global_position:Vector2):
	_global_position=global_position

func get_global_position()->Vector2:
	return _global_position
	
func get_state_key(room:String,item:String)->String:
	return room+'__'+item
	
func set_state_value(room:String,item:String,value):
	_state_value_list.set(get_state_key(room,item),value)
	
func has_state_value(room:String,item:String)->bool:
	return _state_value_list.has(get_state_key(room,item))

func get_state_value(room:String,item:String):
	return _state_value_list.get(get_state_key(room,item))


func open_room(room:String):
	_room_selected=room
	get_tree().change_scene_to_file(_room_dictionary[room])

func go_to_previous_room():
	open_room(_room_selected)
	
func open_item_show_with_name(name:String):
	_item_show_path=_itemDictionary[name]
	get_tree().change_scene_to_file("res://game/shared/item_show.tscn")
	
func get_item_show_path()->String:
	return _item_show_path
