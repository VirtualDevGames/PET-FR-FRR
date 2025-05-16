extends State
class_name PetIdle

var idle_timer : Timer
var state_mb : MarbleBag
var state_mb_array = ["PetWander", "PetWander", "PetWander", "PetWander", "PetSleep"]

func _ready():
	state_mb = MarbleBag.new(state_mb_array)

func Enter():
	pet.anim_sprite.play(anim_name_to_play)
	idle_timer = Global.CreateRandTimer_Range(1, 3, false)
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	add_child(idle_timer)

func Exit():
	if idle_timer:
		idle_timer.queue_free()

func Update(_delta ):
	pass

func Physics_Update(_delta ):
	pass

func _on_idle_timer_timeout():
	Transitioned.emit(self, state_mb.Next())