extends Control

###Variables###
var regex : RegEx = RegEx.new();


###Ready Function###
func _ready():
	regex.compile("\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b");
	#The RegEx is: \b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b



###Play###
func _on_Play_pressed():
	get_node("Menu").visible = false;
	get_node("ServerMenu").visible = true;

###Quit Game###
func _on_Quit_pressed():
	get_tree().quit();

###Back to Main menu###
func _on_Back_pressed():
	get_node("ServerMenu").visible = false;
	get_node("Menu").visible = true;

###Join Server###
func _on_JoinServer_pressed():
	get_node("ServerMenu/Error").visible = false;
	get_node("ServerMenu/Error/ErrorBackground/AdressEmpty").visible = false;
	get_node("ServerMenu/Error/ErrorBackground/InvalidAddress").visible = false;

	if get_node("ServerMenu/IpAddress").text.empty() == false:
		var result = regex.search(get_node("ServerMenu/IpAddress").text);
		if result:
			Server.ip = get_node("ServerMenu/IpAddress").text;
			Server.connectToServer();
#		if get_tree().change_scene("res://scenes/Map.tscn") != OK:
#			print ("An unexpected error occured when trying to switch to the Map scene")
		else:
			get_node("ServerMenu/Error").visible = true;
			get_node("ServerMenu/Error/ErrorBackground/InvalidAddress").visible = true;
	elif get_node("ServerMenu/IpAddress").text.empty() == true:
		get_node("ServerMenu/Error").visible = true;
		get_node("ServerMenu/Error/ErrorBackground/AdressEmpty").visible = true;
