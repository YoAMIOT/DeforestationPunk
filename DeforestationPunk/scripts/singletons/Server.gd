extends Node

###Variables###
var network : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
var ip : String = "127.0.0.1";
var port : int = 4180;

###Signals###
signal successfullyConnected;
signal failedToConnect;



###Function to connect to server###
func connectToServer():
	network.create_client(ip, port);
	get_tree().set_network_peer(network);
	network.connect("connection_failed", self, "connectionFailed");
	network.connect("connection_succeeded", self, "connectionSucceeded");

###On connection failed###
func connectionFailed():
	print("! Failed to connect !");
	emit_signal("failedToConnect");

###On connection successful###
func connectionSucceeded():
	print("===Sucessfully connected===");
	emit_signal("successfullyConnected");

###Func to reset the network connection###
func resetNetworkPeer():
	if get_tree().has_network_peer():
		get_tree().network_peer


###Search the damages in the server's datas###
func fetchDamage(weapon, requester):
	rpc_id(1, "fetchDamage", weapon, requester);

###Func to get back the damage of a weapon###
remote func returnDamage(damage, requester):
	instance_from_id(requester).setDamage(damage);
