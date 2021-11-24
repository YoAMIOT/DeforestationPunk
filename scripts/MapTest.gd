extends Spatial

###Export variables###
export var Pine : PackedScene;
export var Bush : PackedScene;

###Constants###
const MIN_Z_POS : int = -5000;
const MAX_Z_POS : int = 5000;
const MIN_X_POS : int = -5000;
const MAX_X_POS : int = 5000;
const PINE_Y_POS : float = 8.511;
const BUSH_Y_POS : float = 2.905;
const PINE_NUMBER: int = 3000;
const BUSH_NUMBER : int = 5000;

###Variables###
var Rng : RandomNumberGenerator = RandomNumberGenerator.new();



###Ready Function###
func _ready():
	for i in PINE_NUMBER:
		var instance = Pine.instance();
		add_child(instance);
		Rng.randomize();
		var instanceXPos = Rng.randf_range(MIN_X_POS, MAX_X_POS);
		Rng.randomize();
		var instanceZPos = Rng.randf_range(MIN_Z_POS, MAX_Z_POS);
		instance.translation = Vector3(instanceXPos, PINE_Y_POS, instanceZPos);

	for j in BUSH_NUMBER:
		var instance = Bush.instance();
		add_child(instance);
		Rng.randomize();
		var instanceXPos = Rng.randf_range(MIN_X_POS, MAX_X_POS);
		Rng.randomize();
		var instanceZPos = Rng.randf_range(MIN_Z_POS, MAX_Z_POS);
		instance.translation = Vector3(instanceXPos, BUSH_Y_POS, instanceZPos);
