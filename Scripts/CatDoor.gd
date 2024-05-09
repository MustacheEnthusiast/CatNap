extends Node3D
const CDpos = "parameters/DoorAnim/blend_position"
@onready var animator = $Animator
var Cat
@onready var Trigger = $Node3D/CD_Trigger
#var CD_Grav : float = 9
#var CD_Weight : float = 1

var Infront : bool
var InArea : bool

func _ready():
	pass # Replace with function body.


# via  the process function we check if the cat is within the trigger area
# then we tell the animaton tree which value to add to the door blendspace animation
#
func _process(delta):
	if InArea == false:
		
		if Infront == false:
			animator[CDpos] =  clamp(delta + animator[CDpos],-1, 0)
			
		else:
			animator[CDpos] = clamp( animator[CDpos]-delta, 0, 1)
		
		return
	var dir : Vector3 = Cat.global_position - Trigger.global_position 
	var direction
	if Infront == false:
		direction = 1
	else:
		direction = -1
	var dot : float = Trigger.get_global_transform().basis.z.dot(dir) * direction
	#print(clamp(dot + 0.25,0, 1))
	animator[CDpos] = clamp(dot + 0.55,0, 1) * -direction 
	pass



#region Direction checker
# signal function that checks if the body that entered is the player (Cat) and
# gives it's direction to the door which tells it which way it should open
func _on_area_3d_body_entered(_Cat):
	
	if _Cat.name != "Cat":
		
		print(_Cat.name)
		return
	var dir : Vector3 = _Cat.global_position - Trigger.global_position 
	
	var dot : float = Trigger.get_global_transform().basis.z.dot(dir)
	
	InArea = true
	Cat = _Cat
	#print(_Cat.global_position)
	#print(Trigger.global_position)
	#print(dot)
	Infront = dot > 0
	#print(Infront)

func _on_trigger_body_exited(body):
	if body.name == "Cat":
		InArea = false
	pass # Replace with function body.

#endregion


