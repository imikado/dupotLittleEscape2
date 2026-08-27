extends Control

@onready var sprite:Sprite2D=$CenterContainer/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture=load(GlobalPlayer.get_item_show_path())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	GlobalPlayer.go_to_previous_room()
	pass # Replace with function body.
