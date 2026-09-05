extends Node2D

@onready var buttonPlay: Button = $Button

func _ready() -> void:
	build()
func _on_button_pressed() -> void:
	GlobalGame.open_room(GlobalGame.ROOM.BEDROOM)
	pass # Replace with function body.


func build():
	buttonPlay.text = tr('Play')


func _on_option_button_item_selected(index: int) -> void:
	GlobalI18n.set_lang(index)
	pass # Replace with function body.
