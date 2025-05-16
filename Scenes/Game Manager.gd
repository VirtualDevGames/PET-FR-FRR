extends Node

class_name GameManager

class PetData:
	var name : String
	var age : int
	var hunger : int
	var happiness : int

	var hunger_timer : Timer
	var happiness_timer : Timer

class Stat:
	var type : Global.StatType
	var value : int :
		set(_value):
			value = clamp(_value, min_value, max_value)
			Global.StatUpdated.emit(type, value)
		get :
			return value
	var max_value : int
	var min_value : int

	func _init(_type: Global.StatType, _max_value: int, _min_value: int, _value: int = -1) -> void:
		type = _type
		max_value = _max_value
		min_value = _min_value
		value = _value if _value != -1 else _max_value
		Global.StatUpdated.emit(type, value)

var hunger : Stat
var happiness : Stat
var health : Stat
var bathroom : Stat
var coins : Stat

@export_category("Stat Timers")
@export var hunger_timer : Timer
@export var hunger_timer_pbar : ProgressBar
@export var hunger_timer_label : Label
@export var happiness_timer : Timer
@export var happiness_timer_pbar : ProgressBar
@export var happiness_timer_label : Label

@export_category("Coins")
@export var coins_label : Label

func _ready():
	Global.UsedItem.connect(Callable(self, "_on_UsedStatItem"))

	hunger = Stat.new(Global.StatType.HUNGER, 5, 0, 4)
	happiness = Stat.new(Global.StatType.HAPPINESS, 5, 0, 3)
	health = Stat.new(Global.StatType.HEALTH, 5, 0, 5)
	bathroom = Stat.new(Global.StatType.BATHROOM, 5, 0, 5)
	coins = Stat.new(Global.StatType.COINS, 99, 0, 0)

func _process(_delta):
	hunger_timer_label.text = "%0.2f" % hunger_timer.time_left + "s"
	hunger_timer_pbar.value = (hunger_timer.time_left / hunger_timer.wait_time) * 100
	happiness_timer_label.text = "%.2f" % happiness_timer.time_left + "s"
	happiness_timer_pbar.value =  (happiness_timer.time_left / happiness_timer.wait_time) * 100

func _on_UsedStatItem(_type: Global.StatType, _value : int, _cost : int):
	if(coins.value < _cost):
		return

	coins.value -= _cost
	coins_label.text = str(coins.value)

	match _type:
		Global.StatType.HUNGER:
			hunger.value += _value
		Global.StatType.HAPPINESS:
			happiness.value += _value
		Global.StatType.HEALTH:
			health.value += _value
		Global.StatType.COINS:
			coins.value += _value

func _on_hunger_timer_timeout():
	hunger.value -= 1

func _on_happiness_timer_timeout():
	happiness.value -= 1

func _on_pet_button_pressed():
	coins.value += 10
	coins_label.text = str(coins.value)
