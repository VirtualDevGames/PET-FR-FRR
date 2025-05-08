extends HBoxContainer

class_name MenuRibbon

@export var menu_button : MenuButton

func onready():
    menu_button.get_popup().visible = true
    menu_button.get_popup().position.x +=  menu_button.get_popup().position.x + 10