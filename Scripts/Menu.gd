extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	_MenuButtons()


func _MenuButtons():
	
	%StartBtn.pressed.connect(func StartGame():
		
		print("Start")
		
	)
	
	%OptionsBtn.pressed.connect(func OptionsMenu():
		
		print("Options")
		
	)
	
	%CreditsBtn.pressed.connect(func CreditsScreen():
		
		print("Credits")
		
	)
	
	%ExitBtn.pressed.connect(func ExitGame():
		
		get_tree().quit()
		
	)








