extends KinematicBody

###Function to move the puppet###
func movePuppet(newPosition):
	global_transform.origin = newPosition;
