extends Node2D

enum TYPE {
	FAIL,
	BLOB_GREEN,
	BLOB_RED,
	BLOB_BLUE,
	THING_GREEN,
	THING_BLUE,
	THING_RED,
	THING_YELLOW,
	BULL_PURPLE,
	BULL_YELLOW,
	GOBLINS_BLUE,
	GOBLINS_YELLOW,
	HEAD_BLUE,
	HEAD_GREEN,
	HEAD_RED,
	DEATH
}

@export var type: TYPE = TYPE.FAIL

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		TYPE.FAIL:
			$Fail.visible=true
		TYPE.BLOB_GREEN:
			$BlobGreen.visible=true
		TYPE.BLOB_RED:
			$BlobRed.visible=true
		TYPE.BLOB_BLUE:
			$BlobBlue.visible=true
		TYPE.THING_GREEN:
			$ThingGreen.visible=true
		TYPE.THING_BLUE:
			$ThingBlue.visible=true
		TYPE.THING_RED:
			$ThingRed.visible=true
		TYPE.THING_YELLOW:
			$ThingYellow.visible=true
		TYPE.BULL_PURPLE:
			$BullPurple.visible=true
		TYPE.BULL_YELLOW:
			$BullYellow.visible=true
		TYPE.GOBLINS_BLUE:
			$GoblinsBlue.visible=true
		TYPE.GOBLINS_YELLOW:
			$GoblinsYellow.visible=true
		TYPE.HEAD_BLUE:
			$HeadBlue.visible=true
		TYPE.HEAD_GREEN:
			$HeadGreen.visible=true
		TYPE.HEAD_RED:
			$HeadRed.visible=true
		TYPE.DEATH:
			$Death.visible=true
	pass # Replace with function body.
