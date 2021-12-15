extends Spatial

###Variables###
var playerHeight : float = 1.204;
export var ClientPlayer : PackedScene;
export var PlayerPuppet : PackedScene;

###Func to instanciate the client player###
func instanciatePlayer():
	var playerInstance = ClientPlayer.instance();
	get_node(".").add_child(playerInstance);
	playerInstance.transform.origin = Vector3(0, playerHeight, 0);



###Func to instanciate a new player puppet###
func SpawnNewPlayerPuppet(playerId):
	if get_tree().get_network_unique_id() == playerId:
		pass;
	else:
		var playerPuppetInstance = PlayerPuppet.instance();
		playerPuppetInstance.transform.origin = Vector3(2, playerHeight, 2);
		playerPuppetInstance.name = str(playerId);
		get_node("OtherPlayers").add_child(playerPuppetInstance);



###Func to kill a player puppet###
func DespawnPlayerPuppet(playerId):
	get_node("OtherPlayers/" + str(playerId)).queue_free();
