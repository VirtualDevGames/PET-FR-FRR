extends State
class_name PetWander

var speed : float = 200
var has_walked : bool

func _ready():
	call_deferred("NavigationSetup")

func Enter():
	pet.anim_sprite.play(anim_name_to_play)

func Exit():
	has_walked = false
	pet.velocity = Vector2.ZERO

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	if pet.navigaion_agent.is_navigation_finished():
		if has_walked:
			#if randi_range(0, 1) == 1:
			Transitioned.emit(self, "PetIdle")
			return
		SetMovementTarget()
		return

	var target_position = pet.navigaion_agent.get_next_path_position()
	var target_direction = pet.global_position.direction_to(target_position)
	pet.anim_sprite.flip_h = target_direction.x < 0
	pet.velocity = target_direction * speed

func NavigationSetup():
	await get_tree().physics_frame
	await get_tree().physics_frame

	SetMovementTarget()

func SetMovementTarget():
	var target_position : Vector2 = NavigationServer2D.map_get_random_point(pet.navigaion_agent.get_navigation_map(), pet.navigaion_agent.navigation_layers, false)
	pet.navigaion_agent.target_position = target_position
	has_walked = true
