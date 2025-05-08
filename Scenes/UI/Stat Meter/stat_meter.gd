extends ProgressBar

###########################################################################################################################################
# README: 
# Visualizer for the stat it represents.
# Connects to _on_StatUpdated to update when a stat changes.
#
#
###########################################################################################################################################

class_name StatMeterBar

@export var type : Global.StatType

func _init():
    Global.StatUpdated.connect(Callable(self, "_on_StatUpdated"))

func _on_StatUpdated(_type : Global.StatType, _value : int):
    if _type == type:
        value = _value