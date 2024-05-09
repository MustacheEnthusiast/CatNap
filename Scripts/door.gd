extends Node3D

var IS_Interacable : bool = true
var Open : bool = false
var closed : bool = true


func _Open(IS_Interacable):
	
	if Open == false and closed == true and Input.is_action_just_pressed("Interact"):
		
		
		pass
	
	
	
	pass


func _Close(IS_Interacable):
	
	if Open == true and closed == false and Input.is_action_just_pressed("Interact"):
		
		
		pass
	
	pass
