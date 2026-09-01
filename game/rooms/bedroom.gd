extends RoomtAbstract

@onready var furniture_group = $furnitures

const DEBUG = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	if DEBUG:
		GlobalPlayer.add_item_in_inventory(GlobalGame.ITEM_BEDROOM_CLUE)
		GlobalPlayer.add_item_in_inventory(GlobalGame.ITEM_BEDROOM_KEY)
