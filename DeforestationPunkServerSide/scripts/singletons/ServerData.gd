extends Node

###Variables###
var weaponData;

###Ready Function###
func _ready():
	var dataFile : File = File.new();
	# warning-ignore:return_value_discarded
	dataFile.open("res://data/data.json", File.READ);
	var weaponJson = JSON.parse(dataFile.get_as_text());
	dataFile.close();
	weaponData = weaponJson.result;
