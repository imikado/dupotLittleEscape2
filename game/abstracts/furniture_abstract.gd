extends Node
class_name FurnitureAbstract

@export var _sprite:Sprite2D
@export var _control:Control


var selection_tween: Tween


func _ready():
	
	if _control:
		_control.gui_input.connect(on_control_mouse_clicked)
		_control.mouse_entered.connect(on_control_mouse_entered)
		_control.mouse_exited.connect(on_control_mouse_exited)

func on_control_mouse_entered():
	start_blinking()
	

func on_control_mouse_exited():
	stop_blinking()
	

func on_control_mouse_clicked(event: InputEvent) -> void:
	if not GlobalPlayer.is_current_action_selectable():
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		on_action_selected(GlobalPlayer.get_current_action())
		GlobalPlayer.stop_action()
		stop_blinking()
 
func start_blinking():
	
	if not _control or not GlobalPlayer.is_current_action_selectable():
		return
			
	stop_blinking()
	
	# Création du Tween en boucle
	selection_tween = create_tween().set_loops()
	
	selection_tween.tween_property(_sprite, "modulate", Color.GRAY, 0.6)
	selection_tween.tween_property(_sprite, "modulate", Color.WHITE, 0.3)

func stop_blinking():	
	if selection_tween and selection_tween.is_running():
		selection_tween.kill()
	if _sprite:
		_sprite.modulate = Color.WHITE
	
func on_action_selected(action:String):
	GlobalEvents.player_say.emit("I don't think so")
