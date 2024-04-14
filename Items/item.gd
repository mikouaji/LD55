extends Area2D

const IS_ITEM = true

enum TYPE {
	DUST_BLUE,
	DUST_GREEN,
	DUST_PURPLE,
	EGG_BLUE,
	EGG_YELLOW,
	EYE_GREEN,
	EYE_RED,
	FLASK_BLUE,
	FLASK_GREEN,
	FLASK_PURPLE,
	FLASK_RED,
	FLASK_YELLOW,
	LEAF_BLUE,
	LEAF_GREEN,
	LEAF_YELLOW,
	LIZARD,
	MUSHROOM,
	MUSHROOM_BLUE,
	SKULL,
	SPIDER
}
@export var type: TYPE = TYPE.DUST_BLUE
@export var spawn: bool = false
@export var mixIndex: int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		TYPE.DUST_BLUE:
			$DustBlue.visible = true
		TYPE.DUST_GREEN:
			$DustGreen.visible = true
		TYPE.DUST_PURPLE:
			$DustPurple.visible = true
		TYPE.EGG_BLUE:
			$EggBlue.visible = true
		TYPE.EGG_YELLOW:
			$EggYellow.visible = true
		TYPE.EYE_GREEN:
			$EyeGreen.visible = true
		TYPE.EYE_RED:
			$EyeRed.visible = true
		TYPE.FLASK_BLUE:
			$FlaskBlue.visible = true
		TYPE.FLASK_GREEN:
			$FlaskGreen.visible = true
		TYPE.FLASK_PURPLE:
			$FlaskPurple.visible = true
		TYPE.FLASK_RED:
			$FlaskRed.visible = true
		TYPE.FLASK_YELLOW:
			$FlaskYellow.visible = true
		TYPE.LEAF_BLUE:
			$LeafBlue.visible = true
		TYPE.LEAF_GREEN:
			$LeafGreen.visible = true
		TYPE.LEAF_YELLOW:
			$LeafYellow.visible = true
		TYPE.LIZARD:
			$Lizard.visible = true
		TYPE.MUSHROOM:
			$Mushroom.visible = true
		TYPE.MUSHROOM_BLUE:
			$MushroomBlue.visible = true
		TYPE.SKULL:
			$Skull.visible = true
		TYPE.SPIDER:
			$Spider.visible = true
	pass # Replace with function body.

func setActive(val:bool):
	$Active.visible=val

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



#TODO you could add weight here so items fly differently
func isThrown(vect: Vector2):
	var power = vect * 50
	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	#up
	tween.tween_property(self, 'position', position + power/2, 0.25)
	tween.tween_property(self, 'scale', Vector2(1.5,1.5), 0.25)
	#down
	tween.chain().tween_property(self, 'position', position + power, 0.25)
	tween.parallel().tween_property(self, 'scale', Vector2(1,1), 0.25)
	
	await tween.finished
	if global_position.x > 730 or global_position.x < 0 or global_position.y < 40 or global_position.y > 440:
		free()
	pass
