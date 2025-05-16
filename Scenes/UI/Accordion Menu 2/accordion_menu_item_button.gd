extends TextureButton

###########################################################################################################################################
# README: 
#
#
#
###########################################################################################################################################

class_name AccordionMenuItemButton

@export var timer : Timer

var target_position : Vector2
var showing : bool = false

var lerp_speed : float
var original_position : Vector2
var direction : int = 0

var tween : Tween

func _ready():
	original_position = position

func _process(_delta):
	return

func Toggle(_delay : float):
	if showing:
		disabled = true
	timer.wait_time = _delay
	timer.start()

func Disable():
	showing = false

func _on_timer_timeout():
	if !showing:
		tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", Vector2(0, target_position.y), 0.55)
		#tween.interpolate_value(showing, !showing, 0, 0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.tween_callback(ToggleShowing)
	else:
		tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
		tween.tween_callback(ToggleShowing)
		tween.tween_property(self, "position", Vector2(0, original_position.y), 0.15)

func ToggleShowing():
	showing = !showing
	disabled = showing
	return