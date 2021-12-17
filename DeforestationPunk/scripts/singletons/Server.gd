extends Node

###Variables###
var network = null;
var ip : String = "";
var port : int = 4180;

###Signals###
signal successfullyConnected;
signal failedToConnect;



###Function to connect to server###
func connectToServer():
	network = NetworkedMultiplayerENet.new();
	network.create_client(ip, port);
	get_tree().set_network_peer(network);
	var _signalFailedConnect = network.connect("connection_failed", self, "connectionFailed");
	var _signalSuccessConnect = network.connect("connection_succeeded", self, "connectionSucceeded");

###On connection failed###
func connectionFailed():
	print("! Failed to connect !");
	emit_signal("failedToConnect");

###On connection successful###
func connectionSucceeded():
	print("===Sucessfully connected===");
	emit_signal("successfullyConnected");



###Spawn player puppet###
remote func SpawnNewPlayer(playerId, position):
	get_node("../Main").SpawnNewPlayerPuppet(playerId, position);




###DeSpawn player puppet###
remote func DespawnPlayer(playerId):
	get_node("../Main").DespawnPlayerPuppet(playerId);



###Func to reset the network connection###
func resetNetworkPeer():
	if get_tree().has_network_peer():
		network.disconnect("connection_failed", self, "connectionFailed");
		network.disconnect("connection_succeeded", self, "connectionSucceeded");
		get_tree().network_peer = null


###Search the damages in the server's datas###
func fetchDamage(weapon, requester, secondary):
	rpc_id(1, "fetchDamage", weapon, requester, secondary);
###Search the heal in the server's datas###
func fetchHeal(weapon, requester):
	rpc_id(1, "fetchHeal", weapon, requester);

###Func to get back the damage of a weapon###
remote func returnDamage(damage, requester, secondary):
	if secondary == false:
		instance_from_id(requester).setDamage(damage);
	elif secondary == true:
		instance_from_id(requester).setSecondaryDamage(damage);

###Func to get back the heal of a weapon###
remote func returnHeal(heal, requester):
		instance_from_id(requester).setHeal(heal);



###Function to send the player state to the server###
func sendPlayerState(playerState):
	rpc_unreliable_id(1, "receivePlayerState", playerState);

###Function to receive the world state frome the server###
remote func receiveWorldState(worldState):
	get_node("../Main").updateWorldState(worldState);
