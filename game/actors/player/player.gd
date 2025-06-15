extends Node2D
class_name Player

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var playerPrompt: PlayerPrompt = $PlayerPrompt

func _ready() -> void:
	animationPlayer.play('idle')
	playerPrompt.reset()


func start_prompt():
	playerPrompt.start()

func add_choice(label: String, action: Callable):
	playerPrompt.add_choice(label, action)

func show_prompt():
	playerPrompt.display()

func close_prompt():
	playerPrompt.close()
