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
