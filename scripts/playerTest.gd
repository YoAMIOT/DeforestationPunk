extends KinematicBody

###Variables###
var speed : int = 20;
var velocity : Vector3 = Vector3();



###Process Function###
func _physics_process(delta):
	getInput();
	velocity = move_and_slide(velocity, Vector3.UP, true);



###Get Input function###
func getInput():
	velocity = Vector3();
	
	if Input.is_action_pressed("up"):
		velocity.x -= speed;
	if Input.is_action_pressed("down"):
		velocity.x += speed;
	if Input.is_action_pressed("left"):
		velocity.z += speed;
	if Input.is_action_pressed("right"):
		velocity.z -= speed;

	if Input.is_action_just_pressed("pause"):
		if get_node("PauseMenu").visible == true:
			if get_node("PauseMenu/MainPauseMenu").visible == true and get_node("PauseMenu/OptionMenu").visible == false:
				get_node("PauseMenu").visible = false;
			elif get_node("PauseMenu/OptionMenu").visible == true and get_node("PauseMenu/MainPauseMenu").visible == false:
				get_node("PauseMenu/OptionMenu").visible = false;
				get_node("PauseMenu/MainPauseMenu").visible = true;

		elif get_node("PauseMenu").visible == false:
			get_node("PauseMenu").visible = true;
