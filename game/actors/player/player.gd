extends CharacterBody2D
class_name Player

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

@export var speed: float = 2000.0
@export var action_list: Dictionary[String, bool] = {
	GlobalPlayer.ACTION_OPEN: false,
	GlobalPlayer.ACTION_CLOSE: false,
	GlobalPlayer.ACTION_OBSERVE: false,
	GlobalPlayer.ACTION_TAKE: false,
	GlobalPlayer.ACTION_USE: false,
	GlobalPlayer.ACTION_WALK: false
}


@onready var actionGrid: GridContainer = $HUD/CanvasLayer/Panel/MarginContainer/ActionGridContainer
@onready var panel = $PanelContainer
@onready var panel_label = $PanelContainer/MarginContainer/Label

@onready var itemGrid: GridContainer = $HUD/CanvasLayer/Panel/MarginContainer2/ItemGridContainer

#items
@onready var bedsideTableClue: Sprite2D = $HUD/items/BedsideTableClue
@onready var bedroomKey: Sprite2D = $HUD/items/BedroomKey

var button_list: Dictionary[String, Button]

var target_mouse_position = Vector2.ZERO
var physics_paused: bool = false

var stopping_distance: float = 2.0

var can_move = false

var button_enabled: String = ''

func _ready() -> void:
	target_mouse_position = global_position
	animationPlayer.play('idle')
	stop_move()
	
	load_action_button_list()
	load_item_button_list()
	
	panel.visible = false
	
	GlobalEvents.stop_action.connect(on_stop_action)
	GlobalEvents.player_say.connect(say)
	GlobalEvents.refresh_inventory.connect(load_item_button_list)
	
	
func say(message: String):
	panel.visible = true
	panel_label.text = message
	
	await get_tree().create_timer(2.0).timeout
	panel.visible = false
	

func start_move() -> void:
	target_mouse_position = get_global_mouse_position()

func stop_move():
	target_mouse_position = global_position


func _physics_process(delta: float) -> void:
	var distance_to_target: float = global_position.distance_to(target_mouse_position)
		
	if distance_to_target > stopping_distance:
		var direction: Vector2 = global_position.direction_to(target_mouse_position)
		velocity = direction * speed * delta
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	
func load_action_button_list() -> void:
	remove_all_children(actionGrid)
	
	for action_key_loop in action_list:
		if action_list[action_key_loop]:
			var new_button_loop: Button = Button.new()
			new_button_loop.toggle_mode = true
			new_button_loop.text = GlobalI18n.translate(action_key_loop)
			new_button_loop.pressed.connect(start_action.bind(action_key_loop))
			actionGrid.add_child(new_button_loop)
			
			button_list[action_key_loop] = new_button_loop

func refresh_action_button_list() -> void:
	for action_button_loop: Button in actionGrid.get_children():
		action_button_loop.button_pressed = false
		
func load_item_button_list() -> void:
	remove_all_children(itemGrid)
	
	for itemLoop: String in GlobalPlayer.get_item_list_in_inventory():
		var new_button_loop: Button = Button.new()
		new_button_loop.custom_minimum_size = bedroomKey.texture.get_size()
		
		new_button_loop.toggle_mode = true
		
		var button_sprite_loop: Sprite2D = Sprite2D.new()
		
		var sprite_path = GlobalGame.get_item_icon_path(itemLoop)
		button_sprite_loop.texture = load(sprite_path)

		#if itemLoop == GlobalGame.ITEM_BEDROOM_CLUE:
		#	button_sprite_loop = bedsideTableClue.duplicate()
		#elif itemLoop == GlobalGame.ITEM_BEDROOM_KEY:
		#	button_sprite_loop = bedroomKey.duplicate()
			
		new_button_loop.pressed.connect(GlobalGame.open_item_show_with_name.bind(itemLoop))
		
		new_button_loop.add_child(button_sprite_loop)
		button_sprite_loop.position = new_button_loop.custom_minimum_size / 2
		
		itemGrid.add_child(new_button_loop)

func on_stop_action() -> void:
	refresh_action_button_list()

func start_action(action_name: String):
	refresh_action_button_list()
	
	var button_clicked: Button = button_list[action_name]
	button_clicked.button_pressed = true
		
	GlobalPlayer.start_action(action_name)
	
 	
func remove_all_children(object: Node) -> void:
	var children = object.get_children()
	for child_loop in children:
		child_loop.queue_free()
