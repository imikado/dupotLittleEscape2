extends FurnitureAbstract

const ANIM_OPEN = 'open'
const ANIM_CLOSE = 'close'

const ANIM_OPEN_WITH_CLUE = 'open_with_clue'
const ANIM_CLOSE_WITH_CLUE = 'close_with_clue'

const STATE_HAS_CLUE="hasClue"

@export var has_alarm_clock: bool = false
@export var has_clue:bool=false
#@export var item_in_drawer: Node2D = null

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var alarmClock: AnimatedSprite2D = $alarmClock

var opened: bool = false

@onready var alarmClockLabel:Label=$alarmClock/Label
@onready var alarmTimer:Timer=$alarmClock/Label/Timer

var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_id("bedsideTablewithoutAlarmClock")
	alarmClock.visible = has_alarm_clock
	if has_alarm_clock:
		set_id("bedsideTablewithAlarmClock")
		alarmClock.play()
		_on_alarm_timer_timeout()
		
	has_clue=(get_state_value(STATE_HAS_CLUE,STATE_YES)==STATE_YES)
		
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
	var anim:String=ANIM_OPEN
	if has_clue:
		anim=ANIM_OPEN_WITH_CLUE
	animationPlayer.play(anim)
	opened = true

func close_drawer():
	if not opened:
		GlobalEvents.player_say.emit("Already closed")
		return
	var anim:String=ANIM_CLOSE
	if has_clue:
		anim=ANIM_CLOSE_WITH_CLUE
	animationPlayer.play(anim)
	opened = false


func on_action_selected(action: String) -> void:
	
	
	if action == GlobalPlayer.ACTION_OPEN:
		open_drawer()
	elif action == GlobalPlayer.ACTION_CLOSE:
		close_drawer()
	elif action == GlobalPlayer.ACTION_TAKE:
		if opened and has_clue:
			player_say("I take this clue")
			has_clue=false
			animationPlayer.play("open")
			GlobalPlayer.add_item_in_inventory(GlobalPlayer.ITEM_BEDROOM_CLUE)
			set_state_value(STATE_HAS_CLUE,STATE_NO)
	elif action == GlobalPlayer.ACTION_OBSERVE:
		return player_say("It is a bedside table with a drawer ?")
	else:
		return player_say("I don't think so")


func _on_alarm_timer_timeout() -> void:
	var dateDict:Dictionary=Time.get_datetime_dict_from_system()
	alarmClockLabel.text=str(dateDict['hour'])+':'+str(dateDict['minute'])
	
	alarmTimer.stop()
	alarmTimer.start()
	alarmTimer.timeout.connect(_on_alarm_timer_timeout)
	
