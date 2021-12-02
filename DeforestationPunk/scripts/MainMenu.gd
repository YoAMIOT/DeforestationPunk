extends Control

###Play###
func _on_Play_pressed():
	if get_tree().change_scene("res://scenes/Map.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the Map scene")

###Quit Game###
func _on_Quit_pressed():
	get_tree().quit();
