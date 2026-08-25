extends Node

const ACTION_OPEN="action_open"
const ACTION_CLOSE="action_close"
const ACTION_OBSERVE="action_observe"
const ACTION_USE="action_use"
const ACTION_TAKE="action_take"
const ACTION_WALK="action_walk"

const ITEM_BEDROOM_KEY="item_bedroom_key"

var _inventory_list:Array[String]=[]

var _global_position:Vector2=Vector2.ZERO
var _state_value_list:Dictionary={}

func add_item_in_inventory(item:String):
	_inventory_list.append(item)
	
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
