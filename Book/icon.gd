extends TextureRect

var ITEM_TYPE = preload("res://Items/item.gd").TYPE
var DEMON_TYPE = preload("res://Demons/Demon.gd").TYPE
enum SIGN_TYPE {UNKNOWN, PLUS, ARROW}
enum TYPE {ITEM, DEMON, SIGN}

var type: TYPE = TYPE.SIGN
var value = SIGN_TYPE.UNKNOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		TYPE.SIGN:
			setSignIcon()
		TYPE.ITEM:
			setItemIcon()
		TYPE.DEMON:
			setDemonIcon()
	pass # Replace with function body.

func setSignIcon():
	match value:
		SIGN_TYPE.UNKNOWN:
			setIcon(preload("res://Book/unknown.png"))
		SIGN_TYPE.ARROW:
			setIcon(preload("res://Book/arrow.png"))
		SIGN_TYPE.PLUS:
			setIcon(preload("res://Book/plus.png"))
	pass
func setItemIcon():
	match value:
		ITEM_TYPE.DUST_BLUE:
			setIcon(preload("res://Items/dust-blue.png"))
		ITEM_TYPE.DUST_GREEN:
			setIcon(preload("res://Items/dust-green.png"))
		ITEM_TYPE.DUST_PURPLE:
			setIcon(preload("res://Items/dust-purple.png"))
		ITEM_TYPE.EGG_BLUE:
			setIcon(preload("res://Items/egg-blue.png"))
		ITEM_TYPE.EGG_YELLOW:
			setIcon(preload("res://Items/egg-yellow.png"))
		ITEM_TYPE.EYE_GREEN:
			setIcon(preload("res://Items/eye-green.png"))
		ITEM_TYPE.EYE_RED:
			setIcon(preload("res://Items/eye-red.png"))
		ITEM_TYPE.FLASK_BLUE:
			setIcon(preload("res://Items/flask-blue.png"))
		ITEM_TYPE.FLASK_GREEN:
			setIcon(preload("res://Items/flask-green.png"))
		ITEM_TYPE.FLASK_PURPLE:
			setIcon(preload("res://Items/flask-purple.png"))
		ITEM_TYPE.FLASK_RED:
			setIcon(preload("res://Items/flask-red.png"))
		ITEM_TYPE.FLASK_YELLOW:
			setIcon(preload("res://Items/flask-yellow.png"))
		ITEM_TYPE.LEAF_BLUE:
			setIcon(preload("res://Items/leaf-blue.png"))
		ITEM_TYPE.LEAF_GREEN:
			setIcon(preload("res://Items/leaf-green.png"))
		ITEM_TYPE.LEAF_YELLOW:
			setIcon(preload("res://Items/leaf-yellow.png"))
		ITEM_TYPE.LIZARD:
			setIcon(preload("res://Items/lizard.png"))
		ITEM_TYPE.MUSHROOM:
			setIcon(preload("res://Items/muschroom.png"))
		ITEM_TYPE.MUSHROOM_BLUE:
			setIcon(preload("res://Items/muschroom-blue.png"))
		ITEM_TYPE.SKULL:
			setIcon(preload("res://Items/skull.png"))
		ITEM_TYPE.SPIDER:
			setIcon(preload("res://Items/spider.png"))
	pass
func setDemonIcon():
	match value:
		DEMON_TYPE.BLOB_GREEN:
			setIcon(preload("res://Demons/2-green.png"))
		DEMON_TYPE.BLOB_RED:
			setIcon(preload("res://Demons/2-red.png" ))
		DEMON_TYPE.BLOB_BLUE:
			setIcon(preload("res://Demons/2-blue.png" ))
		DEMON_TYPE.THING_GREEN:
			setIcon(preload("res://Demons/1-green.png" ))
		DEMON_TYPE.THING_BLUE:
			setIcon(preload("res://Demons/1-blue.png" ))
		DEMON_TYPE.THING_RED:
			setIcon(preload("res://Demons/1-red.png" ))
		DEMON_TYPE.THING_YELLOW:
			setIcon( preload("res://Demons/1-yellow.png"))
		DEMON_TYPE.BULL_PURPLE:
			setIcon(preload("res://Demons/3-purple.png" ))
		DEMON_TYPE.BULL_YELLOW:
			setIcon(preload("res://Demons/3-yellow.png" ))
		DEMON_TYPE.GOBLINS_BLUE:
			setIcon(preload("res://Demons/4-blue.png" ))
		DEMON_TYPE.GOBLINS_YELLOW:
			setIcon( preload("res://Demons/4-yellow.png"))
		DEMON_TYPE.HEAD_BLUE:
			setIcon( preload("res://Demons/6-blue.png"))
		DEMON_TYPE.HEAD_GREEN:
			setIcon(preload("res://Demons/6-green.png" ))
		DEMON_TYPE.HEAD_RED:
			setIcon(preload("res://Demons/6-red.png" ))
		DEMON_TYPE.DEATH:
			setIcon(preload("res://Demons/5.png" ))
	pass
	
func setIcon(str: CompressedTexture2D):
	var img = str.get_image()
	img.resize(24,24)
	texture = ImageTexture.create_from_image(img)
	set_size(Vector2(32,32))
	pass
