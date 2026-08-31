extends Control

@onready var sprite: TextureRect = $CenterContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = load(GlobalGame.get_item_show_path())
	pass # Replace with function body.


func _on_close_button_pressed() -> void:
	GlobalGame.go_to_previous_room()
	pass # Replace with function body.
