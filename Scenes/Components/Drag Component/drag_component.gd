extends Button
###########################################################################################################################################
# README: 
# Place this component as a child node.
#
# TODO: Decouple the functionality of sticking to the parent pet object
###########################################################################################################################################
class_name DragComponent

var dragging : bool = false :
	set(value):
		dragging = value
var offset : Vector2 = Vector2.ZERO
var valid_placement : bool = false
var target_object : Node
var placed : bool

func _process(_delta):
	if !dragging:
		return
	get_parent().global_position = get_global_mouse_position() - offset

func _on_button_down():
	offset = get_global_mouse_position() - get_parent().global_position
	dragging = true

	if !placed:
		return
	# Reparent to the scene root
	#get_parent().reparent(get_tree().root) working ?
	#get_tree().root.add_child(get_parent()) without reparent
	placed = false

func _on_button_up():
	dragging = false

	# if !valid_placement:
	# 	return

	#target_object.add_child(get_parent())
	#get_parent().reparent(target_object) Working one
	#get_parent().get_parent().remove_child(get_parent())
	#target_object.add_child(get_parent())

	if valid_placement:
		get_parent().reparent(target_object)
	else:
		get_parent().reparent(get_tree().root)

	placed = true

func _on_area_2d_area_entered(_area:Area2D):
	target_object = _area.get_parent()
	valid_placement = true

func _on_area_2d_area_exited(_area:Area2D):
	target_object = null
	valid_placement = false
