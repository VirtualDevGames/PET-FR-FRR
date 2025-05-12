extends Node

signal UsedItem(type: StatType)
signal StatUpdated(type : StatType, value : int)

var draggable_scene = preload("res://Scenes/Components/Drag Component/Drag Component.tscn")

enum StatType {
    HUNGER,
    HAPPINESS,
    HEALTH,
    COINS,
}

func CreateDraggableComponent2(_calling_node : Node2D, _sprite_scale_to_size : Sprite2D):
    var draggable_instance = draggable_scene.instantiate() as DragComponent
    draggable_instance.sprite_scale_to_size = _sprite_scale_to_size;
    _calling_node.add_child(draggable_instance)
    draggable_instance.position = Vector2.ZERO

func CreateRandTimer_Range(_from : float, _to : float, _int : bool) -> Timer:
    var new_timer : Timer = Timer.new()
    if(_int):
        new_timer.wait_time = randi_range(_from, _to)
    else:
        new_timer.wait_time = randf_range(_from, _to)
    new_timer.one_shot = true
    new_timer.autostart = true
    return new_timer