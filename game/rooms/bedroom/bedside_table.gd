extends AbstractFurniture

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var opened: bool = false

func open_drawer():
	opened = true
	animationPlayer.play('open_drawer');

	player.close_prompt()

func close_drawer():
	opened = false
	animationPlayer.play('close_drawer');

	player.close_prompt()

func observe():
	print('observe')
	player.close_prompt()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if GlobalInput.isEventMousePressed(event):
		if opened:
			player.start_prompt()
			player.add_choice('close', close_drawer)
			player.add_choice('observe', observe)
			player.add_choice('observe', observe)

			player.show_prompt()
		else:
			player.start_prompt()
			player.add_choice('open', open_drawer)
			player.add_choice('observe', observe)
			player.show_prompt()
	pass # Replace with function body.
