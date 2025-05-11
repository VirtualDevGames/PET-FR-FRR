extends State
class_name PetIdle

var move_direction : Vector2
var wander_time : float
var speed : float = 200

func _ready():
	call_deferred("NavigationSetup")

func Enter():
	pet.anim_sprite.play(anim_name_to_play)
	#RandomizeWander()

func Exit():
	pass # Replace with function body.

func Update(_delta : float):
	pass
	# if wander_time > 0:
	# 	wander_time -= _delta

	# else:
	# 	RandomizeWander()

func Physics_Update(_delta : float):

	if pet.navigaion_agent.is_navigation_finished():
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

func RandomizeWander():
	move_direction = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
