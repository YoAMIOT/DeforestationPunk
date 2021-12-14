extends KinematicBody

###Variables###
var speed : int = 20;
var velocity : Vector3 = Vector3();
var damage : int;
var secondaryDamage : int;



###Ready function###
func _ready():
	#Ask the server data to get the weapon damage
	Server.fetchDamage("automatic_riffle", get_instance_id(), false);
	Server.fetchDamage("chainsaw", get_instance_id(), true);



###Process Function###
func _physics_process(_delta):
	getInput();
	velocity = move_and_slide(velocity, Vector3.UP, true);



###Get Input function###
func getInput():
	velocity = Vector3();

	if get_node("PauseMenu").visible == false:
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



###Function to set damage###
func setDamage(returnedDamage):
	damage = returnedDamage;
func setSecondaryDamage(returnedDamage):
	secondaryDamage = returnedDamage;
