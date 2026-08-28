extends FurnitureAbstract

const ANIM_OPEN = 'open'
const ANIM_CLOSE = 'close'
const ANIM_OPENED = 'opened'

const ANIM_OPEN_WITH_CLUE = 'open_with_clue'
const ANIM_OPENED_WITH_CLUE = 'opened_with_clue'
const ANIM_CLOSE_WITH_CLUE = 'close_with_clue'

const ANIM_OPEN_WITH_CLUE_CLOCK = 'open_with_clue_clock'
const ANIM_OPENED_WITH_CLUE_CLOCK = 'opened_with_clue_clock'
const ANIM_CLOSE_WITH_CLUE_CLOCK = 'close_with_clue_clock'

const STATE_HAS_CLUE="hasClue"
const STATE_HAS_CLUE_CLOCK="hasClueClock"

@export var has_alarm_clock: bool = false

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var alarmClock: AnimatedSprite2D = $alarmClock

@onready var alarmClockLabel:Label=$alarmClock/Label
@onready var alarmTimer:Timer=$alarmClock/Label/Timer

var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	set_id("bedsideTablewithoutAlarmClock")
	alarmClock.visible = has_alarm_clock
	if has_alarm_clock:
		alarmTimer.timeout.connect(_on_alarm_timer_timeout)

		set_id("bedsideTablewithAlarmClock")
		alarmClock.play()
		_on_alarm_timer_timeout()
		
	if is_opened():
		var anim:String=ANIM_OPENED
		if has_clue():
			anim=ANIM_OPENED_WITH_CLUE
		animationPlayer.play(anim)
		
func stop_clock_animation():
	alarmClock.play("empty")
 
func has_clue()->bool:
	var default:String=STATE_YES
	if has_alarm_clock:
		default=STATE_NO

	return	is_state_value(STATE_HAS_CLUE,STATE_YES,default)

func has_clue_clock()->bool:
	var default:String=STATE_YES
	if not has_alarm_clock:
		default=STATE_NO

	return	is_state_value(STATE_HAS_CLUE_CLOCK,STATE_YES,default)



func open_drawer():
	if is_opened():
		GlobalEvents.player_say.emit("Already opened")
		return
	var anim:String=ANIM_OPEN
	if has_clue():
		anim=ANIM_OPEN_WITH_CLUE
	elif has_clue_clock():
		anim=ANIM_OPEN_WITH_CLUE_CLOCK
	
	animationPlayer.play(anim)
	set_state_value(STATE_OPENED,STATE_YES)

func close_drawer():
	if not is_opened():
		GlobalEvents.player_say.emit("Already closed")
		return
	var anim:String=ANIM_CLOSE
	if has_clue():
		anim=ANIM_CLOSE_WITH_CLUE
	elif has_clue_clock():
		anim=ANIM_CLOSE_WITH_CLUE_CLOCK
	animationPlayer.play(anim)
	set_state_value(STATE_OPENED,STATE_NO)



func on_action_selected(action: String) -> void:
	
	
	if action == GlobalPlayer.ACTION_OPEN:
		open_drawer()
	elif action == GlobalPlayer.ACTION_CLOSE:
		close_drawer()
	elif action == GlobalPlayer.ACTION_TAKE:
		if is_opened() and (has_clue() or has_clue_clock()):
			player_say("I take this clue")
			animationPlayer.play(ANIM_OPENED)
			var item:String
			var state:String
			if has_clue():
				item=GlobalGame.ITEM_BEDROOM_CLUE
				state=STATE_HAS_CLUE
			else:
				item=GlobalGame.ITEM_BEDROOM_CLUE_CLOCK
				state=STATE_HAS_CLUE_CLOCK		
				
			GlobalPlayer.add_item_in_inventory(item)
			set_state_value(state,STATE_NO)
			
	elif action == GlobalPlayer.ACTION_OBSERVE:
		return player_say("It is a bedside table with a drawer ?")
	else:
		return player_say("I don't think so")


func _on_alarm_timer_timeout() -> void:
	var dateDict:Dictionary=Time.get_datetime_dict_from_system()
	alarmClockLabel.text = "%02d:%02d" % [dateDict["hour"], dateDict["minute"]]	
	alarmTimer.stop()
	alarmTimer.start()
	
