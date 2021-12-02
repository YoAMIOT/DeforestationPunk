extends Control

###Variable###
var settingsFile : String = "user://settings.save";
var brightness : float = 1;
var contrast : float = 1;
var distance : float = 150;
var saturation : float = 1;
var fullscreen : bool;
var dofBlur: bool;
var vSync : bool;



###Ready func###
func _ready():
	#Load Data#
	var file : File = File.new();
	if file.file_exists(settingsFile):
		# warning-ignore:return_value_discarded
		file.open(settingsFile, File.READ);
		brightness = file.get_var();
		contrast = file.get_var();
		saturation = file.get_var();
		distance = file.get_var();
		fullscreen = file.get_var();
		dofBlur = file.get_var();
		vSync = file.get_var();
		file.close();

		get_parent().get_node("Camera").environment.adjustment_brightness = brightness;
		get_parent().get_node("Camera").environment.adjustment_contrast = contrast;
		get_parent().get_node("Camera").environment.adjustment_saturation = saturation;
		get_parent().get_node("Camera").far = distance;
		OS.set_window_fullscreen(fullscreen);
		get_parent().get_node("Camera").environment.set_dof_blur_far_enabled(dofBlur);
		get_parent().get_node("Camera").environment.set_dof_blur_near_enabled(dofBlur);
		OS.set_use_vsync(vSync);

	get_node("OptionMenu/OptionsContainer/Vsync/VSync").pressed = OS.vsync_enabled;
	get_node("OptionMenu/OptionsContainer/DoF/DoF").pressed = get_parent().get_node("Camera").environment.dof_blur_far_enabled;
	get_node("OptionMenu/OptionsContainer/Fullscreen/Fullscreen").pressed = OS.window_fullscreen;
	get_node("OptionMenu/OptionsContainer/ViewDistance/ViewDistance").value = get_parent().get_node("Camera").far;
	get_node("OptionMenu/OptionsContainer/Brightness/Brightness").value = get_parent().get_node("Camera").environment.adjustment_brightness;
	get_node("OptionMenu/OptionsContainer/Contrast/Contrast").value = get_parent().get_node("Camera").environment.adjustment_contrast;
	get_node("OptionMenu/OptionsContainer/Saturation/Saturation").value = get_parent().get_node("Camera").environment.adjustment_saturation;



###To Resume Game###
func _on_Resume_pressed():
	visible = false;

###To Quit Game###
func _on_Quit_pressed():
	get_tree().quit();

###To show the Options Menu###
func _on_Options_pressed():
	get_node("MainPauseMenu").visible = false;
	get_node("OptionMenu").visible = true;

###To go back to main Options Menu###
func _on_Back_pressed():
	get_node("OptionMenu").visible = false;
	get_node("MainPauseMenu").visible = true;



###Change Brightness###
func _on_Brightness_value_changed(value):
	get_parent().get_node("Camera").environment.adjustment_brightness = value;
	brightness = value;

###Change Contrast###
func _on_Contrast_value_changed(value):
	get_parent().get_node("Camera").environment.adjustment_contrast = value;
	contrast = value;

###Change Saturation###
func _on_Saturation_value_changed(value):
	get_parent().get_node("Camera").environment.adjustment_saturation = value;
	saturation = value;

###Change View Distance###
func _on_ViewDistance_value_changed(value):
	get_parent().get_node("Camera").far = value;
	distance = value;

###Change Window Mode###
func _on_Fullscreen_toggled(checked : bool):
	OS.set_window_fullscreen(checked);
	fullscreen = checked;

###Change DofBlur###
func _on_DoF_toggled(checked : bool):
	get_parent().get_node("Camera").environment.set_dof_blur_far_enabled(checked);
	get_parent().get_node("Camera").environment.set_dof_blur_near_enabled(checked);
	dofBlur = checked;

###Change V-Sync###
func _on_VSync_toggled(checked : bool):
	OS.set_use_vsync(checked);
	vSync = checked;

###Save Settings###
func _on_Save_pressed():
	var file : File = File.new();
	# warning-ignore:return_value_discarded
	file.open(settingsFile, File.WRITE);
	file.store_var(brightness);
	file.store_var(contrast);
	file.store_var(saturation);
	file.store_var(distance);
	file.store_var(fullscreen);
	file.store_var(dofBlur);
	file.store_var(vSync);
	file.close();
