extends Spatial

###Variables###
var playerHeight : float = 1.204;
var lastWorldState : int = 0;
var worldStateBuffer : Array;
export var ClientPlayer : PackedScene;
export var PlayerPuppet : PackedScene;
const INTERPOLATION_OFFSET : int = 100;

###Func to instanciate the client player###
func instanciatePlayer():
	var playerInstance = ClientPlayer.instance();
	get_node(".").add_child(playerInstance);
	playerInstance.transform.origin = Vector3(0, playerHeight, 0);



###Func to instanciate a new player puppet###
func SpawnNewPlayerPuppet(playerId, position):
	if get_tree().get_network_unique_id() == playerId:
		pass;
	else:
		if not get_node("OtherPlayers").has_node(str(playerId)):
			var playerPuppetInstance = PlayerPuppet.instance();
			playerPuppetInstance.transform.origin = position;
			playerPuppetInstance.name = str(playerId);
			get_node("OtherPlayers").add_child(playerPuppetInstance);



###Func to kill a player puppet###
func DespawnPlayerPuppet(playerId):
	yield(get_tree().create_timer(0.2), "timeout");
	get_node("OtherPlayers/" + str(playerId)).queue_free();



###Function to update the world state###
func updateWorldState(worldState):
	if worldState["T"] > lastWorldState:
		lastWorldState = worldState["T"];
		worldStateBuffer.append(worldState);

###Physics Process###
func _physics_process(delta):
	var renderTime : int = OS.get_system_time_msecs() - INTERPOLATION_OFFSET;
	if worldStateBuffer.size() > 1:
		while worldStateBuffer.size() > 2 and renderTime > worldStateBuffer[2].T:
			worldStateBuffer.remove(0);
		if worldStateBuffer.size() > 2:
			var interpolationFactor : float = float(renderTime - worldStateBuffer[1]["T"]) / float(worldStateBuffer[2]["T"] - worldStateBuffer[1]["T"]);
			for player in worldStateBuffer[2].keys():
				if str(player) == "T":
					continue;
				if player == get_tree().get_network_unique_id():
					continue;
				if not worldStateBuffer[1].has(player):
					continue
				if get_node("OtherPlayers").has_node(str(player)):
					var newPosition = lerp(worldStateBuffer[1][player]["P"], worldStateBuffer[2][player]["P"], interpolationFactor);
					get_node("OtherPlayers/" + str(player)).movePuppet(newPosition);
				else:
					SpawnNewPlayerPuppet(player, worldStateBuffer[2][player]["P"]);
		elif renderTime > worldStateBuffer[1].T:
			var extrapolationFactor : float = float(renderTime - worldStateBuffer[0]["T"]) / float(worldStateBuffer[1]["T"] - worldStateBuffer[0]["T"]) - 1.00;
			for player in worldStateBuffer[1].keys():
				if str(player) == "T":
					continue;
				if player == get_tree().get_network_unique_id():
					continue;
				if not worldStateBuffer[0].has(player):
					continue
				if get_node("OtherPlayers").has_node(str(player)):
					var positionDelta = (worldStateBuffer[1][player]["P"] - worldStateBuffer[0][player]["P"]);
					var newPosition = worldStateBuffer[1][player]["P"] + (positionDelta * extrapolationFactor);
					get_node("OtherPlayers/" + str(player)).movePuppet(newPosition);
