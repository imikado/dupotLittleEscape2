extends Control
class_name Prompt

@onready var panel: Panel = $CanvasLayer/Panel
@onready var panelContainer: VBoxContainer = $CanvasLayer/Panel/MarginContainer/VBoxContainer
@onready var descriptionLabel: Label = $CanvasLayer/Panel/MarginContainer/VBoxContainer/Label


func ready():
	reset()

func reset():
	panel.visible = false
	for childLoop in panelContainer.get_children():
		if childLoop is Button:
			childLoop.queue_free()
	descriptionLabel.text = ""

func set_description(text: String):
	descriptionLabel.text = text


func start():
	reset()

func add_choice(label: String, action: Callable):
	var buttonLoop: Button = Button.new()
	print('addd choice '+label)
	buttonLoop.text = label
	panelContainer.add_child(buttonLoop)
	buttonLoop.pressed.connect(action)

func display():
	panel.visible = true
	await get_tree().process_frame
	var content_height = panelContainer.get_combined_minimum_size().y
	panel.offset_top = -(content_height + 20)



func close():
	reset()
	panel.visible = false
