extends Node2D
class_name RoomtAbstract

@export var _area_2d:Area2D
@export var _ground:TileMapLayer

@export var _player:Player

var selection_tween: Tween

func _ready() -> void:
	if _area_2d:
		_area_2d.input_event.connect(_on_area_2d_input_event)
		_area_2d.mouse_entered.connect(_on_area_2d_mouse_entered)
		_area_2d.mouse_exited.connect(_on_area_2d_mouse_exited)
	
	var saved_position:Vector2=GlobalPlayer.get_global_position()
	if saved_position!=Vector2.ZERO:
		_player.global_position= saved_position
		_player.set_target_position(saved_position)
		
func _on_area_2d_mouse_entered():
	if GlobalPlayer.get_current_action()!=GlobalPlayer.ACTION_WALK:
		return
	start_blinking()

func _on_area_2d_mouse_exited():
	if GlobalPlayer.get_current_action()!=GlobalPlayer.ACTION_WALK:
		return
	stop_blinking()

func start_blinking():
	
	if not _ground:
		return
	if not GlobalPlayer.is_current_action_walkable():
		stop_blinking()
		return
	
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	selection_tween = create_tween().set_loops()
	
	selection_tween.tween_property(_ground, "modulate", Color.GRAY, 0.6)
	selection_tween.tween_property(_ground, "modulate", Color.WHITE, 0.3)

func stop_blinking():	
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	if selection_tween and selection_tween.is_running():
		selection_tween.kill()
	if _ground:
		_ground.modulate = Color.WHITE


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if not GlobalPlayer.is_current_action_walkable():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_player.start_move()
		#GlobalPlayer.stop_action()
		#stop_blinking()

		
