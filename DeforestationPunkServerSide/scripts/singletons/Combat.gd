extends Node

###Searching into datas the damage of a weapon###
func fetchDamage(weapon):
	var damage = ServerData.weaponData[weapon].damage;
	return damage;
