extends Node3D


@export_category("Interaction System")
@export var Holdable : bool



var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity 


var is_held : bool = false

func _physics_process(delta):
	
	if is_held:
		return
	if not is_held:
		velocity.y -= gravity * delta
	

func IS_on_interact_holdable(_caller):
	_caller.AddChild(self)
	is_held = true

func IS_release():
	is_held = false
