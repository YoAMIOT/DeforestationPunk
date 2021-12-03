extends Node

###Variables###
var network : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
var ip : String = "127.0.0.1";
var port : int = 1909;



###Ready Function###
func _ready():
	connectToServer();

###Function to connect to server###
func connectToServer():
	network.create_client(ip, port);
	get_tree().set_network_peer(network);
	network.connect("connection_failed", self, "connectionFailed");
	network.connect("connection_succeeded", self, "connectionSucceeded");

###On connection failed###
func connectionFailed():
	print("! Failed to connect !");

###On connection successful###
func connectionSucceeded():
	print("===Sucessfully connected===");
