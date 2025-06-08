extends Control


@export_enum("left", "right", "top", "bottom")
var side: String = "left"

@export var targetPathTop: String = ''
@export var targetPathBottom: String = ''
@export var targetPathLeft: String = ''
@export var targetPathRight: String = ''

@onready var wallRight: ColorRect = $walls/right
@onready var wallBottom: ColorRect = $walls/bottom
@onready var wallLeft: ColorRect = $walls/left
@onready var wallTop: ColorRect = $walls/top

@onready var arrowLeft: ArrowButton = $arrows/ArrowLeft
@onready var arrowRight: ArrowButton = $arrows/ArrowRight
@onready var arrowBottom: ArrowButton = $arrows/ArrowBottom


@onready var walls: Control = $walls

@onready var arrows: Node2D = $arrows


@onready var side_wall: Dictionary = {
	"left": wallLeft,
	"right": wallRight,
	"top": wallTop,
	"bottom": wallBottom
}

@onready var side_arrow: Dictionary = {
	"left": arrowLeft,
	"right": arrowRight,
	"bottom": arrowBottom
}

func reset():
	for wallLoop: ColorRect in walls.get_children():
		wallLoop.visible = false


func _ready() -> void:
	reset()
	side_wall[side].visible = true

	if (side == 'top'):
		side_arrow['left'].setTargetPath(targetPathLeft)
		side_arrow['right'].setTargetPath(targetPathRight)
		side_arrow['bottom'].setTargetPath(targetPathBottom)
	elif (side == 'bottom'):
		side_arrow['right'].setTargetPath(targetPathLeft)
		side_arrow['left'].setTargetPath(targetPathRight)
		side_arrow['bottom'].setTargetPath(targetPathTop)
	elif (side == 'right'):
		side_arrow['left'].setTargetPath(targetPathTop)
		side_arrow['right'].setTargetPath(targetPathBottom)
		side_arrow['bottom'].setTargetPath(targetPathLeft)
	elif (side == 'left'):
		side_arrow['left'].setTargetPath(targetPathBottom)
		side_arrow['right'].setTargetPath(targetPathTop)
		side_arrow['bottom'].setTargetPath(targetPathRight)
