extends Control

@export var spacing = 10

func _ready():
	queue_redraw()

func _draw():
	var last_end_anchor := Vector2.ZERO
	for child in get_children():
		if child is Control:
			child.position = last_end_anchor
			last_end_anchor.y = child.position.y + child.size.y
			last_end_anchor.y += spacing

	custom_minimum_size = Vector2(custom_minimum_size.x, last_end_anchor.y)
