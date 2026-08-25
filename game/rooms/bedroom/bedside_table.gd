extends FurnitureAbstract

const ANIM_OPEN = 'open'
const ANIM_CLOSE = 'close'

#@export var item_in_drawer: Node2D = null

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var alarmClock: AnimatedSprite2D = $alarmClock

var opened: bool = false

@export var has_alarm_clock: bool = false

var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	alarmClock.visible = has_alarm_clock
	if has_alarm_clock:
		alarmClock.play()
	pass # Replace with function body.

func stop_clock_animation():
	alarmClock.play("empty")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func open_drawer():
	if opened:
		GlobalEvents.player_say.emit("Already opened")
		return
	animationPlayer.play(ANIM_OPEN)
	opened = true

func close_drawer():
	if not opened:
		GlobalEvents.player_say.emit("Already closed")
		return
	animationPlayer.play(ANIM_CLOSE)
	opened = false


	
func on_action_selected(action:String):
	if action==GlobalPlayer.ACTION_OPEN:
		return open_drawer()
	elif action==GlobalPlayer.ACTION_CLOSE:
		return close_drawer()
	GlobalEvents.player_say.emit("I don't think so")
