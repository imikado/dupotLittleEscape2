extends Control

#@onready var besideTable=$CanvasLayer/BedsideTable
@onready var label:Label=$CanvasLayer/Label

@onready var timer:Timer=$Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#besideTable.stop_clock_animation()
	refresh_time()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func refresh_time():
	var time = Time.get_time_dict_from_system()
	
	label.text="%02d  %02d" % [time.hour, time.minute]
	

func _on_timer_timeout() -> void:
	refresh_time()
	timer.start()
	pass # Replace with function body.
