extends Area2D

enum TYPE {
	SI,SII,SIII,SIV,SV,SA,SB
}
@export var type: TYPE = TYPE.SI
# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		TYPE.SI:
			$SI.visible = true
		TYPE.SII:
			$SII.visible = true
		TYPE.SIII:
			$SIII.visible = true
		TYPE.SIV:
			$SIV.visible = true
		TYPE.SV:
			$SV.visible = true
		TYPE.SA:
			$SA.visible = true
		TYPE.SB:
			$SB.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var item = null
signal item_inputted
func _on_area_entered(area : Area2D):
	if !item and 'IS_ITEM' in area and area.get_parent() == get_parent():
		emit_signal("item_inputted", area, type)
		item = area
		area.global_position = global_position
		$ACTIVE.visible = true
	pass # Replace with function body.


signal item_removed
func _on_area_exited(area):
	if item and area == item:
		emit_signal('item_removed', area, type)
		item = null
		$ACTIVE.visible = false
	pass # Replace with function body.
