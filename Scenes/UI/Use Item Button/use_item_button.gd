extends TextureButton

########################################
# README: 
# This script emits the global UsedItem signal 
# which is then received by features that can use it.
#
########################################

class_name UseItemButton

@export var type : Global.StatType
@export var value : int
@export var cost : int

func _on_pressed():
	Global.UsedItem.emit(type, value, cost)