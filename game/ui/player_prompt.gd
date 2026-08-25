extends Control
class_name PlayerPromptOfff

@onready var panel: Panel = $Panel
@onready var panelContainer: VBoxContainer = $Panel/MarginContainer/VBoxContainer

@onready var promptTail: Sprite2D = $Panel/PromptTail

func ready():
	reset()

func reset():
	panel.visible = false
	for childLoop in panelContainer.get_children():
		childLoop.queue_free()
	panel.reset_size()


func start():
	reset()

func add_choice(label: String, action: Callable):
	var buttonLoop: Button = Button.new()
	buttonLoop.text = label
	panelContainer.add_child(buttonLoop)
	buttonLoop.pressed.connect(action)

func display():
	panel.visible = true
	await get_tree().process_frame
	panel.reset_size()

	panel.size = panelContainer.get_combined_minimum_size() + Vector2(10, 10)

	promptTail.global_position.y = panel.global_position.y + panel.size.y - 30


func close():
	reset()
	panel.visible = false
