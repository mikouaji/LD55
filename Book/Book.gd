extends Area2D

var IconScene = preload("res://Book/icon.tscn")

enum SIGN_TYPE {UNKNOWN, PLUS, ARROW}
enum TYPE {ITEM, DEMON, SIGN}

const IS_BOOK = true

var known = [];

func _ready():
	initRecipes()
	pass # Replace with function body.

func initRecipes():
	for i in $GUI/S/Mixes.get_children():
		i.queue_free()
	for i in $GUI/S/Demons.get_children():
		i.queue_free()
	
	#items
	var itemRecipes = get_parent().MIXING_RECIPES
	for i in itemRecipes:
		var isKnown = known.find(i) != -1
		var removed = randi_range(0,1)
		var e1 = IconScene.instantiate()
		e1.type = TYPE.SIGN if removed && !isKnown else TYPE.ITEM
		e1.value = SIGN_TYPE.UNKNOWN if removed && !isKnown else i[0]
		var e2 = getPlusIcon()
		var e3 = IconScene.instantiate()
		e3.type = TYPE.SIGN if !removed && !isKnown else TYPE.ITEM
		e3.value = SIGN_TYPE.UNKNOWN if !removed && !isKnown else i[1]
		var e4 = getArrowIcon()
		var e5 = IconScene.instantiate()
		e5.type = TYPE.ITEM
		e5.value = itemRecipes[i]
		addItemRecipe([e1,e2,e3,e4,e5])
		
	#demons
	var demonRecipes = get_parent().DEMON_RECIPES
	for i in demonRecipes:
		var isKnown = known.find(i) != -1
		var removed = randi_range(0,1)
		var e1 = IconScene.instantiate()
		e1.type = TYPE.SIGN if removed == 0 && !isKnown else TYPE.ITEM
		e1.value = SIGN_TYPE.UNKNOWN if removed == 0 && !isKnown else i[0]
		var e2 = getPlusIcon()
		var e3 = IconScene.instantiate()
		e3.type = TYPE.SIGN if removed == 1 && !isKnown else TYPE.ITEM
		e3.value = SIGN_TYPE.UNKNOWN if removed == 1 && !isKnown else i[1]
		var e4 = getPlusIcon()
		
		var removed2 = randi_range(0,1)
		var e5 = IconScene.instantiate()
		e5.type = TYPE.SIGN if removed2 ==0 && !isKnown else TYPE.ITEM
		e5.value = SIGN_TYPE.UNKNOWN if removed2 == 0 && !isKnown else i[2]
		var e6 = getPlusIcon()
		var e7 = IconScene.instantiate()
		e7.type = TYPE.SIGN if removed2 == 1 && !isKnown else TYPE.ITEM
		e7.value = SIGN_TYPE.UNKNOWN if removed2 == 1 && !isKnown else i[3]
		var e8 = getPlusIcon()
		
		var removed3 = randi_range(0,1)
		var e9 = IconScene.instantiate()
		e9.type = TYPE.SIGN if removed3 == 1 && !isKnown else TYPE.ITEM
		e9.value = SIGN_TYPE.UNKNOWN if removed3 == 1 && !isKnown else i[4]
		var e10 = getArrowIcon()
		var e11 = IconScene.instantiate()
		e11.type = TYPE.DEMON
		e11.value = demonRecipes[i]
		
		addDemonRecipe([e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11])
		
	pass

func getArrowIcon():
	var e = IconScene.instantiate()
	e.type = TYPE.SIGN
	e.value = SIGN_TYPE.ARROW
	return e

func getPlusIcon():
	var e = IconScene.instantiate()
	e.type = TYPE.SIGN
	e.value = SIGN_TYPE.PLUS
	return e

func addItemRecipe(recipe: Array):
	var container = HBoxContainer.new()
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	for e in recipe:
		container.add_child(e)
	$GUI/S/Mixes.add_child(container)
	pass

func addDemonRecipe(recipe: Array):
	var container = HBoxContainer.new()
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	for e in recipe:
		container.add_child(e)
	$GUI/S/Demons.add_child(container)
	pass

func _on_body_entered(body):
	if body == get_parent().player:
		$S1.visible = true
		$S2.visible = true
		body.bookInRange = self


func _on_body_exited(body):
	if body == get_parent().player:
		$S1.visible = false
		$S2.visible = false
		body.bookInRange = null
		$GUI.visible = false

func addKnown(index: Array):
	known.push_front(index)
	initRecipes()
	pass

func toggle():
	$GUI.visible = !$GUI.visible
