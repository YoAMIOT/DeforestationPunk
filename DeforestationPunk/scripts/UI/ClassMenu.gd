extends Control

###Variables###
export var basicSoldierBody : PackedScene;
export var repairerBody : PackedScene;
export var lumberJackBody : PackedScene;
export var sniperBody : PackedScene;

###Ready Function###
func _ready():
	if get_parent().has_node("Body"):
		get_node("../Body").queue_free();

func _on_BasicSoldier_pressed():
	get_parent().fetchBasicSoldierStats();
	var bodyInstance = basicSoldierBody.instance();
	get_parent().add_child(bodyInstance);
	get_parent().classType = "basicSoldier";
	get_node(".").visible = false;

func _on_Repairer_pressed():
	get_parent().fetchRepairerStats();
	var bodyInstance = repairerBody.instance();
	get_parent().add_child(bodyInstance);
	get_parent().classType = "repairer";
	get_node(".").visible = false;

func _on_LumberJack_pressed():
	get_parent().fetchLumberJackStats();
	var bodyInstance = lumberJackBody.instance();
	get_parent().add_child(bodyInstance);
	get_parent().classType = "lumberJack";
	get_node(".").visible = false;

func _on_Sniper_pressed():
	get_parent().fetchSniperStats();
	var bodyInstance = sniperBody.instance();
	get_parent().add_child(bodyInstance);
	get_parent().classType = "sniper";
	get_node(".").visible = false;
