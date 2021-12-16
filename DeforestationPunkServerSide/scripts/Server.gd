extends Node

###Variables###
var network : NetworkedMultiplayerENet = NetworkedMultiplayerENet.new();
var ip : String;
var port : int = 4180;
var maxPlayers : int = 20;
var upnp : UPNP = UPNP.new();
var serverStarted : bool = false;
onready var Log = get_node("UI/Log");
var playerStateCollection : Dictionary;



###Ready function###
func _ready():
	OS.set_window_fullscreen(false);
	# warning-ignore:return_value_discarded
	upnp.discover(2000, 2, "InternetGatewayDevice");
	ip = upnp.query_external_address();
	get_node("UI/IpLabel").text = ip;



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
	Log.logPrint("===Server Started===");
	Log.logPrint("=Currently running on " + ip + "=");
	var _singalPeerConnect = network.connect("peer_connected", self, "peerConnected");
	var _singalPeerDisconnect = network.connect("peer_disconnected", self, "peerDisconnected");



###Connected peer function###
func peerConnected(playerId):
	Log.logPrint("!- User" + str(playerId) + " Connected -!");
	rpc_id(0, "SpawnNewPlayer", playerId);

 ###Disconnected peer function###
func peerDisconnected(playerId):
	Log.logPrint("!- User" + str(playerId) + " Disconnected -!");
	rpc_id(0, "DespawnPlayer", playerId);
	playerStateCollection.erase(playerId);



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



###Function called by the client to receive the player state###
remote func receivePlayerState(playerState):
	var playerId = get_tree().get_rpc_sender_id();
	if playerStateCollection.has(playerId):
		if playerStateCollection[playerId]["T"] < playerState["T"]:
			playerStateCollection[playerId] = playerState;
	else:
		playerStateCollection[playerId] = playerState;

###Function to send back the world state to the player###
func sendWorldState(worldState):
	rpc_unreliable_id(0, "receiveWorldState", worldState);
