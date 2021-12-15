extends Control

###Variables###
export var basicSoldierBody : PackedScene;
export var repairerBody : PackedScene;
export var lumberJackBody : PackedScene;
export var sniperBody : PackedScene;

func _on_BasicSoldier_pressed():
	get_parent().fetchBasicSoldierStats();
	if get_parent().has_node("Body"):
		get_node("../Body").queue_free();
	var bodyInstance = basicSoldierBody.instance();
	get_parent().add_child(bodyInstance);
	get_node(".").visible = false;

func _on_Repairer_pressed():
	get_parent().fetchRepairerStats();
	if get_parent().has_node("Body"):
		get_node("../Body").queue_free();
	var bodyInstance = repairerBody.instance();
	get_parent().add_child(bodyInstance);
	get_node(".").visible = false;

func _on_LumberJack_pressed():
	get_parent().fetchLumberJackStats();
	if get_parent().has_node("Body"):
		get_node("../Body").queue_free();
	var bodyInstance = lumberJackBody.instance();
	get_parent().add_child(bodyInstance);
	get_node(".").visible = false;

func _on_Sniper_pressed():
	get_parent().fetchSniperStats();
	if get_parent().has_node("Body"):
		get_node("../Body").queue_free();
	var bodyInstance = sniperBody.instance();
	get_parent().add_child(bodyInstance);
	get_node(".").visible = false;
