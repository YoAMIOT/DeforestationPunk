extends Control

###Variables###
var regex : RegEx = RegEx.new();
var connectionSuccess : bool = false;


###Ready Function###
func _ready():
# warning-ignore:return_value_discarded
	regex.compile("\\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\b");
	#The RegEx is: \b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b
	var _signalFailedConnect = Server.connect("failedToConnect", self, "onConnectionFailed");
	var _signalSuccessConnect = Server.connect("successfullyConnected", self, "onConnectionSuccess");



###Play###
func _on_Play_pressed():
	get_node("Menu").visible = false;
	get_node("ServerMenu").visible = true;

###Quit Game###
func _on_Quit_pressed():
	get_tree().quit();

###Back to Main menu###
func _on_Back_pressed():
	get_node("ServerMenu").visible = false;
	get_node("Menu").visible = true;



###Join Server###
func _on_JoinServer_pressed():
	get_node("ServerMenu/Error").visible = false;
	get_node("ServerMenu/Error/ErrorBackground/AdressEmpty").visible = false;
	get_node("ServerMenu/Error/ErrorBackground/InvalidAddress").visible = false;

	#If the line is not blank 
	if get_node("ServerMenu/IpAddress").text.empty() == false:
		var result = regex.search(get_node("ServerMenu/IpAddress").text);
		#If the address is valid
		if result:
			Server.ip = get_node("ServerMenu/IpAddress").text;
			Server.connectToServer();
			get_node("ServerMenu").visible = false;
			get_node("ConnectingToServer").visible = true;
			get_node("ConnectingToServer/ConnectionTimeOut").start();
		#If the address is not valid
		else:
			get_node("ServerMenu/Error").visible = true;
			get_node("ServerMenu/Error/ErrorBackground/InvalidAddress").visible = true;
	#If the line is blank
	elif get_node("ServerMenu/IpAddress").text.empty() == true:
		get_node("ServerMenu/Error").visible = true;
		get_node("ServerMenu/Error/ErrorBackground/AdressEmpty").visible = true;

###When receiving a failed connection signal###
func onConnectionFailed():
	get_node("ConnectingToServer/ConnectingLabel").visible = false;
	get_node("ConnectingToServer/LoadingAnim").visible = false;
	get_node("ConnectingToServer/ConnectionFailedLabel").visible = true;
	get_node("ConnectingToServer/5sTimerFailure").start();

###When receiving a signal of successful connection###
func onConnectionSuccess():
	get_node("ConnectingToServer/ConnectingLabel").visible = false;
	get_node("ConnectingToServer/LoadingAnim").visible = false;
	get_node("ConnectingToServer/ConnectedLabel").visible = true;
	connectionSuccess = true;
	get_node("ConnectingToServer/3sTimerSuccess").start();

###On connection timeout###
func _on_Timer_timeout():
	if connectionSuccess == false:
		get_node("ConnectingToServer/ConnectingLabel").visible = false;
		get_node("ConnectingToServer/LoadingAnim").visible = false;
		get_node("ConnectingToServer/ConnectionFailedLabel").visible = true;
		get_node("ConnectingToServer/5sTimerFailure").start();

###5 seconds after a failure occurs###
func _on_5sTimerFailure_timeout():
	get_node("ConnectingToServer/ConnectingLabel").visible = true;
	get_node("ConnectingToServer/LoadingAnim").visible = true;
	get_node("ConnectingToServer/ConnectedLabel").visible = false;
	get_node("ConnectingToServer/ConnectionFailedLabel").visible = false;
	get_node("ConnectingToServer").visible = false;
	get_node("ServerMenu").visible = true;
	Server.resetNetworkPeer();

###3 seconds after the succeeded connection###
func _on_3sTimerSuccess_timeout():
	get_parent().instanciatePlayer();
	get_node(".").visible = false;
