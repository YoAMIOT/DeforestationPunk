extends Node

###Variables###
var network : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
var port : int = 1909;
var maxPlayers : int = 20;



###Ready function###
func _ready():
	startServer();



###Start server function###
func startServer():
	network.create_server(port, maxPlayers);
	get_tree().set_network_peer(network);
	print("===Server Started===");
	
	network.connect("peer_connected", self, "peerConnected");
	network.connect("peer_disconnected", self, "peerDisconnected");

###Connected peer function###
func peerConnected(playerId):
	print("User" + str(playerId) + " Connected!");

 ###Disconnected peer function###
func peerDisconnected(playerId):
	print("User" + str(playerId) + " Disconnected!");
