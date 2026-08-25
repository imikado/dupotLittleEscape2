extends NavigationRegion2D

# Make sure to enable pickable on the Area2D so it detects the mouse
@onready var hover_area = $Area2D

func _ready():
	# This line is crucial! Area2D needs this to detect the mouse.
	hover_area.input_pickable = true 
	
	# Connect the signals programmatically (or do it via the Editor Node tab)
	hover_area.mouse_entered.connect(_on_mouse_entered)
	hover_area.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	# Change to a system cursor shape (e.g., POINTING_HAND, CROSS, IBEAM)
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)

func _on_mouse_exited():
	# Reset back to the normal arrow when leaving
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
