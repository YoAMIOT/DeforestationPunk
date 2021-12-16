extends Node

###Variables###
var network : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
var port : int = 4180;
var maxPlayers : int = 20;
var upnp : UPNP = UPNP.new();
var serverStarted : bool = false;



###Ready function###
func _ready():
	OS.set_window_fullscreen(false);
	# warning-ignore:return_value_discarded
	upnp.discover(2000, 2, "InternetGatewayDevice");
	get_node("UI/IpLabel").text = upnp.query_external_address();



###Button Start Server pressed###
func _on_StartServerButton_pressed():
	startServer();
	serverStarted = true;
	get_node("UI/StartServerButton").disabled = true;

###Start server function###
func startServer():
	# warning-ignore:return_value_discarded
	network.create_server(port, maxPlayers);
	get_tree().set_network_peer(network);
	get_node("UI/Log").logPrint("===Server Started===");
	var _singalPeerConnect = network.connect("peer_connected", self, "peerConnected");
	var _singalPeerDisconnect = network.connect("peer_disconnected", self, "peerDisconnected");



###Connected peer function###
func peerConnected(playerId):
	get_node("UI/Log").logPrint("!- User" + str(playerId) + " Connected -!");
	rpc_id(0, "SpawnNewPlayer", playerId)

 ###Disconnected peer function###
func peerDisconnected(playerId):
	get_node("UI/Log").logPrint("!- User" + str(playerId) + " Disconnected -!");
	rpc_id(0, "DespawnPlayer", playerId)



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
