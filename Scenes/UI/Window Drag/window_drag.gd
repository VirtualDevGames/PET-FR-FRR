extends Control

########################################
# README: 
# Used to simulate a ribbon for dragging
# the window.
#
########################################

class_name WindowDrag

var following = false
var dragging_start_position = Vector2()

func _process(_delta):
	if following:
		var mouse_position = get_local_mouse_position()
		var window_position = Vector2(DisplayServer.window_get_position())
		DisplayServer.window_set_position(window_position + (mouse_position - dragging_start_position))

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1:
			following = !following
			dragging_start_position = get_local_mouse_position()
