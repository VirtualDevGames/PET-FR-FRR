extends State
class_name PetIdle

var idle_timer : Timer

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
	if randi_range(0, 1) == 1:
		Transitioned.emit(self, "PetWander")
	else:
		Transitioned.emit(self, "PetSleep")
