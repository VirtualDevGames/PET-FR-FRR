extends Panel

var is_expanded := false
var last_rect_size := Vector2.ZERO
var target_height := 70.0
var collapsed_height := .01
var lerp_speed := 0.05
@export var button : TextureButton
@export var vbox_child : VBoxContainer

func _ready():
	button.pressed.connect(expand)
	target_height = vbox_child.get_children().size() * 32

func expand():
	is_expanded = !is_expanded

func _process(_delta):
	var current_height = custom_minimum_size.y
	var goal_height = target_height if is_expanded else collapsed_height

	# Smoothly interpolate towards target height
	var new_height = lerp(current_height, goal_height, lerp_speed)

	# Snap to end if close enough
	if abs(new_height - goal_height) < 1.0:
		new_height = goal_height

	custom_minimum_size.y = new_height
	size.y = custom_minimum_size.y

	# Only update layout if size changed
	if last_rect_size.y != new_height:
		last_rect_size.y = new_height
		get_parent().queue_redraw()

# TODO : Eventually make this unroll instead of appear with clipping and changing
#        min size. Can probably hide the buttons outside of the clipped area and
#        move y down to have them appear.