extends Node

###Variables###
var network : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
var port : int = 4180;
var maxPlayers : int = 20;



###Ready function###
func _ready():
	startServer();



###Start server function###
func startServer():
	# warning-ignore:return_value_discarded
	network.create_server(port, maxPlayers);
	get_tree().set_network_peer(network);
	print("===Server Started===");
	var _singalPeerConnect = network.connect("peer_connected", self, "peerConnected");
	var _singalPeerDisconnect = network.connect("peer_disconnected", self, "peerDisconnected");

###Connected peer function###
func peerConnected(playerId):
	print("!- User" + str(playerId) + " Connected -!");

 ###Disconnected peer function###
func peerDisconnected(playerId):
	print("!- User" + str(playerId) + " Disconnected -!");



###Function called by client to know the damage of a weapon###
remote func fetchDamage(weapon, requester, secondary):
	var playerId = get_tree().get_rpc_sender_id();
	var damage = Combat.fetchDamage(weapon);
	rpc_id(playerId, "returnDamage", damage, requester, secondary);

###Function called by client to know the heal of a weapon###
remote func fetchHeal(weapon, requester):
	var playerId = get_tree().get_rpc_sender_id();
	var heal = Combat.fetchHeal(weapon);
	rpc_id(playerId, "returnHeal", heal, requester);
