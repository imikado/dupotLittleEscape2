extends Node2D

var action_selected:String=""
@onready var furniture_group=$furnitures
@export var player:Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GlobalEvents.start_action.connect(on_start_action)
	GlobalEvents.stop_action.connect(on_stop_action)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_start_action(action:String):
	print('start '+action)
	if action==GlobalPlayer.ACTION_WALK:
		for furniture_loop:FurnitureAbstract in furniture_group.get_children():
			furniture_loop.stop_selection()
		return
			
	for furniture_loop in furniture_group.get_children():
		furniture_loop.start_selection(action)
		
	action_selected=action
	
func on_stop_action():
	player.refresh_action_button_list()
	print('stop '+action_selected)
	for furniture_loop:FurnitureAbstract in furniture_group.get_children():
		furniture_loop.stop_selection()
	action_selected=''
	
