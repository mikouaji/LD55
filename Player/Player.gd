extends CharacterBody2D

const SPEED = 200.0
var hasItem = false

var throwPower:float = 0.0
var throwPowerIncrease = true

var facingDirection: Vector2 = Vector2.UP
func _physics_process(delta):
	
	if hasItem:
		if Input.is_action_pressed('ui_select'):
			if throwPower > 10:
				throwPowerIncrease = false
			if throwPower < 0:
				throwPowerIncrease = true
			throwPower += (9 * delta) if throwPowerIncrease else (-7 * delta)
			$Control.visible = throwPower > 1.5 or !throwPowerIncrease
			$Control/ThrowPower.value = throwPower
			

	if Input.is_action_just_released("ui_select"):
		if itemInRange and !hasItem:
			if itemInRange.spawn:
				var clonedItem = itemInRange.duplicate()
				clonedItem.spawn = false
				clonedItem.position = itemInRange.position
				itemInRange.setActive(false)
				itemInRange = clonedItem
				get_parent().add_child(itemInRange)
			itemInRange.reparent(self)
			get_parent().playPick()
			itemInRange.setActive(false)
			get_parent().mixedItemPicked(itemInRange.mixIndex)
			itemInRange.mixIndex=-1
			hasItem = true
		elif hasItem:
			if throwPower > 1.5:
				await itemInRange.isThrown(facingDirection * throwPower)
			if is_instance_valid(itemInRange):
				itemInRange.show_behind_parent = false
				itemInRange.reparent(get_parent())
				itemInRange.setActive(false)
				get_parent().playThrow()
			itemInRange = null
			hasItem = false
		$Control.visible = false
		throwPower = 0
		
		if bookInRange:
			bookInRange.toggle()

	if Input.is_action_just_pressed('ui_up'):
		facingDirection = Vector2.UP
		$Sprite.play('back')
		positionItemWhenChangingDirection(Vector2.UP)
	if Input.is_action_just_pressed('ui_down'):
		facingDirection = Vector2.DOWN
		$Sprite.play('default')
		positionItemWhenChangingDirection(Vector2.DOWN)
	if Input.is_action_just_pressed('ui_left'):
		facingDirection = Vector2.LEFT
		$Sprite.scale.x = -1
		$Sprite.play('default')
		positionItemWhenChangingDirection(Vector2.LEFT)
	if Input.is_action_just_pressed('ui_right'):
		facingDirection = Vector2.RIGHT
		$Sprite.scale.x = 1
		$Sprite.play('default')
		positionItemWhenChangingDirection(Vector2.RIGHT)

	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", 'ui_down')
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if velocity == Vector2.ZERO:
		$Sprite.stop()

	var x = move_and_slide()

var itemInRange : Area2D = null

func positionItemWhenChangingDirection(direction: Vector2):
	if hasItem and is_instance_valid(itemInRange):
			itemInRange.show_behind_parent = false
			match direction:
				Vector2.UP:
					itemInRange.position = Vector2(0, -32)
					itemInRange.show_behind_parent = true
				Vector2.DOWN:
					itemInRange.position = Vector2(0, 12)
				Vector2.LEFT:
					itemInRange.position = Vector2(-16, 0)
				Vector2.RIGHT:
					itemInRange.position = Vector2(16, 0)
	pass

var bookInRange = null
func _on_area_2d_area_entered(area: Area2D):	
	if 'IS_ITEM' in area and !itemInRange:
		itemInRange = area
		itemInRange.setActive(true)
	pass


func _on_area_2d_area_exited(area):
	if is_instance_valid(itemInRange) and !hasItem && area == itemInRange:
		itemInRange.setActive(false)
		itemInRange = null
	pass # Replace with function body.

