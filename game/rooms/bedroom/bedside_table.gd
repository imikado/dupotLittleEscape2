extends Node2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var opened: bool = false

func open_drawer():
	animationPlayer.play('open_drawer');

func close_drawer():
	animationPlayer.play('close_drawer');


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if GlobalInput.isEventMousePressed(event):
		if opened:
			close_drawer()
			opened = false
		else:
			open_drawer()
			opened = true
	pass # Replace with function body.
