extends Node2D
class_name Accessory

@export var sprite : Sprite2D

func _ready():
    sprite = get_node("Sprite2D");