extends Node

func isEventMousePressed(event: InputEvent) -> bool:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        return true
    return false