extends Node2D
class_name ArrowButton

@export_enum("left", "right", "top", "bottom")
var side: String = "left"

var targetScenePath: String

@onready var arrowRight: Sprite2D = $arrows/ArrowRight
@onready var arrowBottom: Sprite2D = $arrows/ArrowBottom
@onready var arrowLeft: Sprite2D = $arrows/ArrowLeft
@onready var arrowTop: Sprite2D = $arrows/ArrowTop

@onready var arrows: Node2D = $arrows

@onready var animation: AnimationPlayer = $AnimationPlayer

@onready var side_sprites: Dictionary = {
    "left": arrowLeft,
    "right": arrowRight,
    "top": arrowTop,
    "bottom": arrowBottom
}

func setTargetPath(targetPath: String):
    targetScenePath = targetPath

func reset():
    for child in arrows.get_children():
        child.visible = false


func _ready() -> void:
    reset()
    side_sprites[side].visible = true

    if (side == "left" || side == "right"):
        animation.play('move_horiz')
    else:
        animation.play('move_vert')

    pass

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if GlobalInput.isEventMousePressed(event):
        print('go to scehe:' + targetScenePath)
        get_tree().change_scene_to_file(targetScenePath)
