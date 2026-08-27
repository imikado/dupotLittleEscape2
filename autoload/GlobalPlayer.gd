extends Node

const ACTION_OPEN = "action_open"
const ACTION_CLOSE = "action_close"
const ACTION_OBSERVE = "action_observe"
const ACTION_USE = "action_use"
const ACTION_TAKE = "action_take"
const ACTION_WALK = "action_walk"


var _inventory_list: Array[String] = []

var _global_position: Vector2 = Vector2.ZERO

var _action_selected: String = ""


func start_action(action: String):
	_action_selected = action

func stop_action():
	_action_selected = ""
	GlobalEvents.stop_action.emit()
	
func get_current_action():
	return _action_selected
	
func has_current_action() -> bool:
	return _action_selected != ''

func is_current_action_walkable() -> bool:
	return _action_selected == ACTION_WALK

func is_current_action_selectable() -> bool:
	return _action_selected != ACTION_WALK and _action_selected != ''

func add_item_in_inventory(item: String):
	_inventory_list.append(item)
	GlobalEvents.refresh_inventory.emit()
	
func has_item_in_inventory(item: String) -> bool:
	return _inventory_list.has(item)

func get_item_list_in_inventory() -> Array[String]:
	return _inventory_list

func set_global_position(global_position: Vector2):
	_global_position = global_position

func get_global_position() -> Vector2:
	return _global_position
