extends Control

###To Resume Game###
func _on_Resume_pressed():
	visible = false;

###To Quit Game###
func _on_Quit_pressed():
	get_tree().quit();

###To show the Options Menu###
func _on_Options_pressed():
	get_node("MainPauseMenu").visible = false;
	get_node("OptionMenu").visible = true;
