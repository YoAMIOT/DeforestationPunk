extends KinematicBody

###Variables###
var speed : int = 20;
var velocity : Vector3 = Vector3();
var damage : int;
var secondaryDamage : int;
var heal : int;
var classType : String = "none";
var playerState : Dictionary;

###Process Function###
func _physics_process(_delta):
	getInput();
	definePlayerState();
	velocity = move_and_slide(velocity, Vector3.UP, true);


###Get Input function###
func getInput():
	velocity = Vector3();

	if get_node("PauseMenu").visible == false:
		if Input.is_action_just_pressed("classMenu"):
			classType = "none";
			get_node("ClassMenu").visible = true;
			if get_node(".").has_node("Body"):
				get_node("Body").queue_free();
		if classType != "none":
			if Input.is_action_pressed("up"):
				velocity.x -= 1;
				get_node("Body").rotation_degrees.y = 180;
			if Input.is_action_pressed("down"):
				velocity.x += 1;
				get_node("Body").rotation_degrees.y = 0;
			if Input.is_action_pressed("left"):
				velocity.z += 1;
				get_node("Body").rotation_degrees.y = 270;
			if Input.is_action_pressed("right"):
				velocity.z -= 1;
				get_node("Body").rotation_degrees.y = 90;
			if Input.is_action_just_pressed("shoot"):
				print(damage);
			if Input.is_action_just_pressed("secondary"):
				print(secondaryDamage);
				print(heal);


		if velocity == Vector3(-1,0,-1):
			get_node("Body").rotation_degrees.y = 135;
		elif velocity == Vector3(-1,0,1):
			get_node("Body").rotation_degrees.y = 225;
		elif velocity == Vector3(1,0,1):
			get_node("Body").rotation_degrees.y = 315;
		elif velocity == Vector3(1,0,-1):
			get_node("Body").rotation_degrees.y = 45;

	if Input.is_action_just_pressed("pause"):
		if get_node("PauseMenu").visible == true:
			if get_node("PauseMenu/MainPauseMenu").visible == true and get_node("PauseMenu/OptionMenu").visible == false:
				get_node("PauseMenu").visible = false;
			elif get_node("PauseMenu/OptionMenu").visible == true and get_node("PauseMenu/MainPauseMenu").visible == false:
				get_node("PauseMenu/OptionMenu").visible = false;
				get_node("PauseMenu/MainPauseMenu").visible = true;

		elif get_node("PauseMenu").visible == false:
			get_node("PauseMenu").visible = true;

	velocity = velocity.normalized() * speed;



###Function to setup the player state and send it to the server###
func definePlayerState():
	playerState = {"T" : OS.get_system_time_msecs(), "P" : global_transform.origin};
	Server.sendPlayerState(playerState);



###Function to get the stats of the BasicSoldier###
func fetchBasicSoldierStats():
	Server.fetchDamage("automatic_riffle", get_instance_id(), false);
	Server.fetchDamage("rocket_launcher", get_instance_id(), true);
	setHeal(0);

###Function to get the stats of the BasicSoldier###
func fetchRepairerStats():
	Server.fetchDamage("automatic_riffle", get_instance_id(), false);
	Server.fetchDamage("welding_torch", get_instance_id(), true);
	Server.fetchHeal("welding_torch", get_instance_id());

###Function to get the stats of the BasicSoldier###
func fetchLumberJackStats():
	Server.fetchDamage("automatic_riffle", get_instance_id(), false);
	Server.fetchDamage("chainsaw", get_instance_id(), true);
	setHeal(0);

###Function to get the stats of the BasicSoldier###
func fetchSniperStats():
	Server.fetchDamage("sniper", get_instance_id(), false);
	setSecondaryDamage(0);
	setHeal(0);



###Function to set damage###
func setDamage(returnedDamage):
	damage = returnedDamage;
func setSecondaryDamage(returnedDamage):
	secondaryDamage = returnedDamage;
###Function to set heal###
func setHeal(returnedHeal):
	heal = returnedHeal;
