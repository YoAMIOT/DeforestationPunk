extends Node

var worldState : Dictionary;

func _physics_process(delta):
	if not get_node("../Server").playerStateCollection.empty():
		worldState = get_node("../Server").playerStateCollection.duplicate(true)
		for player in worldState.keys():
			worldState[player].erase("T");
		worldState["T"] = OS.get_system_time_msecs();
		get_node("../Server").sendWorldState(worldState);
