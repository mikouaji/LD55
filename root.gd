extends Node

const ItemScene = preload("res://Items/item.tscn")
const ITEM_TYPE = preload("res://Items/item.gd").TYPE

const DemonScene = preload("res://Demons/demon.tscn")
const DEMON_TYPE = preload("res://Demons/Demon.gd").TYPE

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	$GUI/CNT/Welcome/Button.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#if Input.is_action_pressed('ui_cancel'):
		#get_tree().quit()
	
	if Input.is_action_just_released("music"):
		$Sounds/Music.playing = !$Sounds/Music.playing
	
	pass


var mixingItems = {
	'A': null,
	'B': null
}

var summonItems = {
	'I':null,
	'II':null,
	'III':null,
	'IV':null,
	'V':null,
}

const MIXING_RECIPES = {
	[ITEM_TYPE.DUST_BLUE, ITEM_TYPE.DUST_GREEN]: ITEM_TYPE.DUST_PURPLE,
	[ITEM_TYPE.MUSHROOM, ITEM_TYPE.DUST_BLUE]: ITEM_TYPE.MUSHROOM_BLUE,
	[ITEM_TYPE.EYE_RED, ITEM_TYPE.FLASK_GREEN]: ITEM_TYPE.EYE_GREEN,
	[ITEM_TYPE.LIZARD, ITEM_TYPE.FLASK_BLUE]: ITEM_TYPE.EGG_BLUE,
	[ITEM_TYPE.SPIDER, ITEM_TYPE.FLASK_BLUE]: ITEM_TYPE.EGG_BLUE,
	[ITEM_TYPE.SPIDER, ITEM_TYPE.FLASK_YELLOW]: ITEM_TYPE.EGG_YELLOW,
	[ITEM_TYPE.LIZARD, ITEM_TYPE.FLASK_YELLOW]: ITEM_TYPE.EGG_YELLOW,
	[ITEM_TYPE.LIZARD, ITEM_TYPE.FLASK_RED]: ITEM_TYPE.SKULL,
	[ITEM_TYPE.LEAF_GREEN, ITEM_TYPE.DUST_BLUE]: ITEM_TYPE.LEAF_BLUE,
	[ITEM_TYPE.LEAF_GREEN, ITEM_TYPE.FLASK_YELLOW]: ITEM_TYPE.LEAF_YELLOW,
	[ITEM_TYPE.LEAF_GREEN, ITEM_TYPE.FLASK_BLUE]: ITEM_TYPE.FLASK_GREEN,
	[ITEM_TYPE.FLASK_YELLOW, ITEM_TYPE.FLASK_RED]: ITEM_TYPE.FLASK_PURPLE
}

var mixingResultCounter = 0
var mixingResults = {
	0:null,1:null,2:null,3:null,4:null
}

func parseMixing():
	if mixingItems.A && mixingItems.B && mixingResultCounter < 5:
		var index1 = [mixingItems.A.type, mixingItems.B.type]
		var index2 = [mixingItems.B.type, mixingItems.A.type]
		var properIndex = index1 if index1 in MIXING_RECIPES else index2 if index2 in MIXING_RECIPES else null
		var newItemType = mixingItems.A.type
		if properIndex:
			newItemType = MIXING_RECIPES[properIndex]
		var mixedItem = ItemScene.instantiate()
		mixedItem.type = newItemType
		if !mixingResults[0]:
			mixedItem.position = Vector2(390, 65)
			mixedItem.mixIndex = 0
			mixingResults[0] = mixedItem
		elif !mixingResults[1]:
			mixedItem.position = Vector2(460, 65)
			mixedItem.mixIndex = 1
			mixingResults[1] = mixedItem
		elif !mixingResults[2]:
			mixedItem.position = Vector2(525, 65)
			mixedItem.mixIndex = 2
			mixingResults[2] = mixedItem
		elif !mixingResults[3]:
			mixedItem.position = Vector2(600, 65)
			mixedItem.mixIndex = 3
			mixingResults[3] = mixedItem
		elif !mixingResults[4]:
			mixedItem.position = Vector2(670, 65)
			mixedItem.mixIndex = 4
			mixingResults[4] = mixedItem
		mixingResultCounter+=1
		add_child(mixedItem)
		mixingItems.A.queue_free()
		mixingItems.B.queue_free()
		mixingItems.A = null
		mixingItems.B = null
		$Sounds/MixSound.play()
		if properIndex:
			$Book.addKnown(properIndex)
	pass

func mixedItemPicked(index: int):
	if index >=0 and mixingResults[index]:
		mixingResults[index] = null
		mixingResultCounter-=1


const DEMON_RECIPES = {
	[ITEM_TYPE.DUST_GREEN,ITEM_TYPE.MUSHROOM, ITEM_TYPE.LEAF_GREEN, ITEM_TYPE.FLASK_GREEN, ITEM_TYPE.EYE_RED]:DEMON_TYPE.BLOB_GREEN,
	[ITEM_TYPE.DUST_BLUE,ITEM_TYPE.MUSHROOM, ITEM_TYPE.LEAF_GREEN, ITEM_TYPE.FLASK_BLUE, ITEM_TYPE.EYE_RED]:DEMON_TYPE.BLOB_BLUE,
	[ITEM_TYPE.DUST_PURPLE,ITEM_TYPE.MUSHROOM, ITEM_TYPE.LEAF_GREEN, ITEM_TYPE.FLASK_RED, ITEM_TYPE.EYE_RED]:DEMON_TYPE.BLOB_RED,
	[ITEM_TYPE.FLASK_BLUE, ITEM_TYPE.MUSHROOM, ITEM_TYPE.SPIDER, ITEM_TYPE.LIZARD, ITEM_TYPE.EGG_BLUE]:DEMON_TYPE.THING_BLUE,
	[ITEM_TYPE.FLASK_GREEN, ITEM_TYPE.MUSHROOM, ITEM_TYPE.SPIDER, ITEM_TYPE.LIZARD, ITEM_TYPE.LEAF_GREEN]:DEMON_TYPE.THING_GREEN,
	[ITEM_TYPE.FLASK_RED, ITEM_TYPE.MUSHROOM, ITEM_TYPE.SPIDER, ITEM_TYPE.LIZARD, ITEM_TYPE.EYE_RED]:DEMON_TYPE.THING_RED,
	[ITEM_TYPE.FLASK_YELLOW, ITEM_TYPE.MUSHROOM, ITEM_TYPE.SPIDER, ITEM_TYPE.LIZARD, ITEM_TYPE.EGG_YELLOW]:DEMON_TYPE.THING_YELLOW,
	[ITEM_TYPE.LEAF_BLUE, ITEM_TYPE.EGG_BLUE, ITEM_TYPE.MUSHROOM_BLUE, ITEM_TYPE.FLASK_PURPLE, ITEM_TYPE.LIZARD]:DEMON_TYPE.BULL_PURPLE,
	[ITEM_TYPE.LEAF_YELLOW, ITEM_TYPE.EGG_YELLOW, ITEM_TYPE.MUSHROOM, ITEM_TYPE.FLASK_YELLOW, ITEM_TYPE.LIZARD]:DEMON_TYPE.BULL_YELLOW,
	[ITEM_TYPE.SPIDER, ITEM_TYPE.EYE_RED, ITEM_TYPE.MUSHROOM_BLUE, ITEM_TYPE.DUST_BLUE, ITEM_TYPE.LIZARD]:DEMON_TYPE.GOBLINS_BLUE,
	[ITEM_TYPE.SPIDER, ITEM_TYPE.EYE_RED, ITEM_TYPE.EGG_YELLOW, ITEM_TYPE.FLASK_YELLOW, ITEM_TYPE.LIZARD]:DEMON_TYPE.GOBLINS_YELLOW,
	[ITEM_TYPE.SKULL, ITEM_TYPE.EYE_GREEN, ITEM_TYPE.EYE_RED, ITEM_TYPE.LEAF_BLUE,ITEM_TYPE.DUST_BLUE]:DEMON_TYPE.HEAD_BLUE,
	[ITEM_TYPE.SKULL, ITEM_TYPE.EYE_GREEN, ITEM_TYPE.EYE_RED, ITEM_TYPE.LEAF_GREEN,ITEM_TYPE.DUST_GREEN]:DEMON_TYPE.HEAD_GREEN,
	[ITEM_TYPE.SKULL, ITEM_TYPE.EYE_GREEN, ITEM_TYPE.EYE_RED, ITEM_TYPE.LEAF_YELLOW,ITEM_TYPE.DUST_PURPLE]:DEMON_TYPE.HEAD_RED,
	[ITEM_TYPE.SKULL, ITEM_TYPE.MUSHROOM_BLUE, ITEM_TYPE.EYE_GREEN, ITEM_TYPE.LEAF_BLUE, ITEM_TYPE.FLASK_RED]:DEMON_TYPE.DEATH,
	#[ITEM_TYPE.FLASK_BLUE, ITEM_TYPE.FLASK_BLUE, ITEM_TYPE.FLASK_BLUE, ITEM_TYPE.FLASK_BLUE, ITEM_TYPE.FLASK_BLUE]:DEMON_TYPE.DEATH,
}
 
var summonned = []
var demonRef = null

func parseSummon():
	if summonItems.I && summonItems.II && summonItems.III and summonItems.IV and summonItems.V:
		var ingredients = [summonItems.I.type,summonItems.II.type,summonItems.III.type,summonItems.IV.type,summonItems.V.type]
		ingredients.sort()
		var demonType = DEMON_TYPE.FAIL
		var success = null
		for i in DEMON_RECIPES:
			var sorted = i.duplicate()
			sorted.sort()
			if sorted == ingredients:
				demonType = DEMON_RECIPES[i]
				$Book.addKnown(i)
				success = i
		var demon = DemonScene.instantiate()
		demon.type = demonType
		demon.position = Vector2(500, 290)
		demon.scale = demon.scale * 2
		$FIre.visible = true
		$Sounds/SummonSound.play()
		await get_tree().create_timer(2.0).timeout
		add_child(demon)
		$FIre.visible = false
		demonRef = demon
		summonItems.I.queue_free()
		summonItems.II.queue_free()
		summonItems.III.queue_free()
		summonItems.IV.queue_free()
		summonItems.V.queue_free()
		summonItems.I = null
		summonItems.II = null
		summonItems.III = null
		summonItems.IV = null
		summonItems.V = null
		
		var options = [
			'UNDERSTANDS WHAT JUST HAPPENED',
			'KILLS ME',
			'DESTROYS EVERYTHING',
		]
		var opt = randi_range(0,2)
		var text = 'SUCCESS!!! \r\n NOW QUICK SEND IT BACK \r\n BEFORE IT \r\n'+options[opt] if demonType != DEMON_TYPE.FAIL else "WELL I'M GLAD \r\n I DIDN'T TURN INTO THAT"
		if demonType == DEMON_TYPE.FAIL:
			$Sounds/SummonSoundFail.play()
		$GUI/CNT/Summon/Label.text = text
		$GUI/CNT/Summon/Button.grab_focus()
		$GUI.visible = true
		$GUI/CNT/Summon.visible = true
		$GUI/placeholder/TextureRect.visible=false
		if success:
			summonned.push_front(success)
		
	pass

func _on_item_input_item_inputted(item: Area2D, type: int):
	match type:
		0:
			summonItems.I = item
		1:
			summonItems.II = item
		2:
			summonItems.III = item
		3:
			summonItems.IV = item
		4:
			summonItems.V = item
		5:
			mixingItems.A = item
		6:
			mixingItems.B = item
	parseMixing()
	parseSummon()
	pass # Replace with function body.

func _on_item_input_item_removed(item: Area2D, type: int):
	match type:
		0:
			if summonItems.I == item:
				summonItems.I = null
		1:
			if summonItems.II == item:
				summonItems.II = null
		2:
			if summonItems.III == item:
				summonItems.III = null
		3:
			if summonItems.IV == item:
				summonItems.IV = null
		4:
			if summonItems.V == item:
				summonItems.V = null
		5:
			if mixingItems.A == item:
				mixingItems.A = null
		6:
			if mixingItems.B == item:
				mixingItems.B = null
	pass # Replace with function body.




func _on_summon_pressed():
	$GUI/CNT/Summon.visible = false
	$GUI/placeholder/TextureRect.visible=true
	var counter = 0
	for i in DEMON_RECIPES:
		if summonned.find(i) != -1:
			counter+=1
	if counter == DEMON_RECIPES.size():
		for i in get_children():
			if "IS_ITEM" in i:
				i.queue_free()
		$Timer.stop()
		var minutes = floor(time / 60)
		var seconds = time % 60
		$GUI/CNT/Win/Label.text = $GUI/CNT/Win/Label.text + '\r\n' + String.num(minutes) + " MINUTES AND \r\n" +   String.num(seconds) + " SECONDS"
		$GUI/CNT/Win.visible = true
		await get_tree().create_timer(10.0).timeout
		$GUI/placeholder/TextureRect.visible=false
		
	else:
		$GUI.visible = false
	if demonRef:
		demonRef.queue_free()
		demonRef = null
	pass # Replace with function body.

var time = 0
func _on_start_button_pressed():
	$GUI/CNT/Welcome.visible = false
	$GUI.visible = false
	$Timer.start()
	$Sounds/Music.play()
	pass # Replace with function body.


func _on_timer_timeout():
	time+=1
	var minutes = floor(time / 60)
	var seconds = time % 60
	var text = String.num(minutes) +":"+ ("0" if seconds < 10 else "") + String.num(seconds)
	$Time.text = text
	pass # Replace with function body.

func playPick():
	$Sounds/PickSound.play()
func playThrow():
	$Sounds/ThrowSound.play()


func _on_music_finished():
	$Sounds/Music.play()
	pass # Replace with function body.
