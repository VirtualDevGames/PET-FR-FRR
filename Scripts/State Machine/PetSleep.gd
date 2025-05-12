extends State
class_name PetSleep

var sleep_timer : Timer

func Enter():
	pet.anim_sprite.play(anim_name_to_play)
	sleep_timer = Global.CreateRandTimer_Range(5, 10, true)
	sleep_timer.timeout.connect(_on_sleep_timer_timeout)
	add_child(sleep_timer)

func Exit():
	if sleep_timer:
		sleep_timer.queue_free()

func Update(_delta ):
	pass

func Physics_Update(_delta ):
	pass

func _on_sleep_timer_timeout():
	Transitioned.emit(self, "PetIdle")