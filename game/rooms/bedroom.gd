extends Node2D

@onready var furniture_group=$furnitures
@export var player:Player

@export var area_2d:Area2D

@export var ground:TileMapLayer

var selection_tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if area_2d:
		# Connexion du signal de détection de clic
		area_2d.input_event.connect(_on_area_2d_input_event)
		area_2d.mouse_entered.connect(_on_area_2d_mouse_entered)
		area_2d.mouse_exited.connect(_on_area_2d_mouse_exited)

func _on_area_2d_mouse_entered():
	if GlobalPlayer.get_current_action()!=GlobalPlayer.ACTION_WALK:
		return
	start_blinking()

func _on_area_2d_mouse_exited():
	if GlobalPlayer.get_current_action()!=GlobalPlayer.ACTION_WALK:
		return
	stop_blinking()

func start_blinking():
	
	if not ground:
		return
			
	stop_blinking()
	
	# Création du Tween en boucle
	selection_tween = create_tween().set_loops()
	
	# Teinte le sprite en rouge (ou n'importe quelle autre couleur) en 0.3 sec
	selection_tween.tween_property(ground, "modulate", Color.GRAY, 0.6)
	# Revient à la couleur d'origine (blanc neutre) en 0.3 sec
	selection_tween.tween_property(ground, "modulate", Color.WHITE, 0.3)

func stop_blinking():	
	if selection_tween and selection_tween.is_running():
		selection_tween.kill()
	if ground:
		ground.modulate = Color.WHITE


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	# Vérifie si l'événement est un clic gauche de souris enfoncé
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GlobalEvents.stop_action.emit()
		print('click move')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
