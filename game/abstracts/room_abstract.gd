extends Node2D
class_name RoomAbstract

@export var _ground: TileMapLayer

@export var _player: Player

var selection_tween: Tween


func _ready() -> void:
	var saved_position: Vector2 = GlobalPlayer.get_global_position()
	if _player and saved_position != Vector2.ZERO:
		_player.global_position = saved_position
		_player.set_target_position(saved_position)

func _unhandled_input(event: InputEvent) -> void:
	if not GlobalPlayer.is_current_action_walkable():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_player.start_move()
		get_viewport().set_input_as_handled()

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
