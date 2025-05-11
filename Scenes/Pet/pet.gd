extends CharacterBody2D

###########################################################################################################################################
# README: 
#
#
#
###########################################################################################################################################

class_name Pet

@export var anim_sprite : AnimatedSprite2D # = $"AnimatedSprite2D"
@export var navigaion_agent : NavigationAgent2D # = $"NavigationAgent2D"

func _ready():
    pass

func _physics_process(_delta):
    move_and_slide()