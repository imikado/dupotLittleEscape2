extends Node
class_name FurnitureAbstract

@export var sprite: Sprite2D
@export var area_2d: Area2D

var action_selected:String=""

var selection_tween: Tween

func _ready():
	if area_2d:
		# Connexion du signal de détection de clic
		area_2d.input_event.connect(_on_area_2d_input_event)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	# Vérifie si l'événement est un clic gauche de souris enfoncé
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GlobalEvents.stop_action.emit()
		on_action_selected(action_selected)

func start_selection(action:String):
	action_selected=action
	print('action started')
	
	if not sprite:
		return
	
	stop_selection()
	
	# Création du Tween en boucle
	selection_tween = create_tween().set_loops()
	
	# Teinte le sprite en rouge (ou n'importe quelle autre couleur) en 0.3 sec
	selection_tween.tween_property(sprite, "modulate", Color.GRAY, 0.3)
	# Revient à la couleur d'origine (blanc neutre) en 0.3 sec
	selection_tween.tween_property(sprite, "modulate", Color.WHITE, 0.3)

func stop_selection():
	print('action stopped')
	if selection_tween and selection_tween.is_running():
		selection_tween.kill()
	if sprite:
		sprite.modulate = Color.WHITE
	
func on_action_selected(action:String):
	GlobalEvents.player_say.emit("I don't think so")
