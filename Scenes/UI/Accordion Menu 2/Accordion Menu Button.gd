extends TextureButton

###########################################################################################################################################
# README:
#
#
#
###########################################################################################################################################
class_name AccordionMenuButton


var children : Array[AccordionMenuItemButton]

@export var buttons_parent : Panel

@export_category("List Positioning Settings Values")
@export_enum("Vertical", "Horizontal") var direction = 0
@export var _offset_from_origin : int = 12
@export var _separation_between_children : int = 5
@export var _children_size : int = 32
@export var lerp_speed : float = 0.01
@export var delay_between_children : float = 0.08

var active = false

func _ready():
	for i in range(buttons_parent.get_child_count()):
		var curr_child : AccordionMenuItemButton = buttons_parent.get_child(i)
		children.append(curr_child)
		curr_child.target_position = SetPositionOnList(i, _offset_from_origin, _separation_between_children, _children_size)
		curr_child.direction = direction
		curr_child.lerp_speed = lerp_speed


func _process(_delta):
	pass

# public Vector2 SetPositionOnGrid(int _index, bool _is_starting_pos)
#     {
#         Vector2 gridPosition;

#         // - LEFT TO RIGHT -
#         // Calculate column index (left-to-right)
#         int column = _index % GridSize;
#         // Calculate row index (top-to-bottom)
#         int row = _index / GridSize;
#         // Calculate the position based on your grid layout
#         if (_is_starting_pos)
#             gridPosition = new Vector2(column * (gridspace - 125) + xoffset - 1000, row * gridspace);
#         else
#             gridPosition = new Vector2(column * gridspace  + xoffset, row * gridspace);


#         // Set the node's position
#         return gridPosition;
#     }

# index 1 : 12 + (5 * 1) + (32 * 1)
# index 2 : 12 + (5 * 2) + (32 * 2)
func SetPositionOnList(_index : int, _offset : int, _separation : int, _unit_size) -> Vector2:
	var list_position : Vector2

	#Verical
	if direction == 0:
		list_position = Vector2(0, _offset + (_separation * _index) + (32 * _index))
		return list_position

	#Horizontal
	list_position = Vector2(_offset + (_separation * _index) + (32 * _index), 0)
	return list_position

# 	public override void _Process(double delta)
# 	{
# 		if(showing){
# 			if (Mathf.Round(Position.X) != targetPosition.X){
# 				Position = new Vector2(Mathf.Lerp(Position.X, targetPosition.X, lerp_speed), Position.Y);
# 			}
# 		}
# 	}

# 	public void ShowMaterial() {
# 		showing = true;
# 	}

# 	/// <summary>
# 	/// Delay to appear in the list.
# 	/// </summary>
# 	/// <param name="delayTime"></param>
# 	public void CreateDelayTimer(float delayTime){
# 		Timer timer = new Timer();
# 		timer.WaitTime = delayTime;
# 		timer.OneShot = true;
# 		timer.Autostart = true;
# 		timer.Timeout += ShowMaterial;
# 		AddChild(timer);
# 	}

# 	public void BubbleDisappear(float _delay = 0){
# 		bubbleAppear.Hide(_delay);
# 	}

func _on_pressed():
	if active:
		for i in range(children.size()):
			children[i].Toggle(i * delay_between_children + 0.0000001)
	else:
		for i in range(children.size()):
			children[i].Toggle((children.size() - 1 - i) * delay_between_children + 0.0000001)
	
	active = !active