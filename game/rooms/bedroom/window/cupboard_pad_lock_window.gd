extends FurnitureAbstract


@onready var grid: GridContainer = $Control/GridContainer

@onready var labelCode: Label = $Control/Panel/Label

@onready var clearButton: Button = $Control/ClearButton
@onready var validButton: Button = $Control/ValidButton

@onready var panelCode: Panel = $Control/Panel

@onready var closeButtom: Button = $Control/CloseButton

const PLACEHOLDER = "______"
const PASSWORD = "BA1530"

var code: String = ""

var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	set_id("cupboard")
	
	closeButtom.pressed.connect(close_window)
	
	clearButton.pressed.connect(reset_code)
	validButton.pressed.connect(check_code)
	
	for btn_loop in grid.get_children():
		btn_loop.queue_free()
		
	reset_code()
	
	for btn_loop in [
		"1", "2", "3",
		"4", "5", "6",
		"7", "8", "9",
		"A", "0", "B"
	]:
		var new_btn = Button.new()
		new_btn.text = btn_loop
		var padding := 0
		new_btn.add_theme_font_size_override("font_size", 4)
		new_btn.add_theme_constant_override("margin_left", padding)
		new_btn.add_theme_constant_override("margin_top", padding)
		new_btn.add_theme_constant_override("margin_right", padding)
		new_btn.add_theme_constant_override("margin_bottom", padding)
		new_btn.pressed.connect(press_button.bind(btn_loop))
		grid.add_child(new_btn)
	pass # Replace with function body.

func press_button(text: String):
	code += text
	labelCode.text = (code + PLACEHOLDER).substr(0, 6)
	
func reset_code():
	code = ""
	labelCode.text = PLACEHOLDER
	
func check_code():
	if code == PASSWORD:
		set_unlocked_state()
		set_opened_state()
		GlobalGame.set_pending_event(GlobalGame.ASYNC_EVENT_BEDROOM_CUPBOARD_OPEN)
		
		GlobalGame.go_to_previous_room()
	else:
		blink_red()
		reset_code()
		 
	pass
	
func blink_red():
	if tween:
		tween.kill()
	
	# Sauvegarde de la couleur d'origine
	var original_color: Color = panelCode.self_modulate
	
	# Boucle limitée à 2 répétitions au lieu d'une boucle infinie
	tween = create_tween().set_loops(2)
	
	# 1. Passe au rouge
	tween.tween_property(panelCode, "self_modulate", Color.RED, 0.3)
	# 2. Revient à la couleur d'origine
	tween.tween_property(panelCode, "self_modulate", original_color, 0.3)
	
	# Sécurité : garantit le retour exact à la couleur de base après les 2 cycles
	tween.finished.connect(func(): panelCode.self_modulate = original_color, CONNECT_ONE_SHOT)


func close_window():
	GlobalGame.go_to_previous_room()
