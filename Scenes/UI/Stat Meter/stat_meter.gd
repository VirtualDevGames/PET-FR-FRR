extends Control

###########################################################################################################################################
# README:
# Visualizer for the stat it represents.
# Connects to _on_StatUpdated to update when a stat changes.
#
# Progress Bar meter texture_rect set in Theme Type Variation
###########################################################################################################################################
class_name StatMeterBar

@export var type : Global.StatType

@export_enum("ProgressBar", "Label") var style

@onready var label : Label = get_node("Label")
@onready var texture_rect : TextureRect = get_node("TextureRect")
@onready var progress_bar : ProgressBar = get_node("ProgressBar")

func _ready():
	Global.StatUpdated.connect(Callable(self, "_on_StatUpdated"))
	match type:
		Global.StatType.HUNGER:
			texture_rect.texture = Global.hunger_sprite
			progress_bar.theme_type_variation = "HungerBar"
		Global.StatType.HAPPINESS:
			texture_rect.texture = Global.happiness_sprite
		Global.StatType.BATHROOM:
			texture_rect.texture = Global.bathroom_sprite
			progress_bar.theme_type_variation = "Bathroom"

	match style:
		0:
			label.visible = false
			texture_rect.visible = false
			progress_bar.visible = true
		1:
			label.visible = true
			texture_rect.visible = true
			progress_bar.visible = false

func _on_StatUpdated(_type : Global.StatType, _value : int):
	if _type == type:
		progress_bar.value = _value
		label.text = str(_value)
