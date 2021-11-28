extends Control

###Play###
func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Map.tscn");

###Quit Game###
func _on_Quit_pressed():
	get_tree().quit();
