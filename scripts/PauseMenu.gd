extends Control

###Variables###
var dofBlurOn : String = "Depth of Field: On";
var dofBlurOff : String = "Depth of Field: Off";
var windowModeFullscreen : String = "Window: Fullscreen"
var windowModeWindowed : String = "Window: Windowed"

###Ready func###
func _ready():
	if get_parent().get_node("Camera").environment.dof_blur_far_enabled == true and get_parent().get_node("Camera").environment.dof_blur_near_enabled == true:
		get_node("OptionMenu/OptionsContainer/DoF").text = dofBlurOn;
	elif get_parent().get_node("Camera").environment.dof_blur_far_enabled == false and get_parent().get_node("Camera").environment.dof_blur_near_enabled == false:
		get_node("OptionMenu/OptionsContainer/DoF").text = dofBlurOff;
	get_node("OptionMenu/OptionsContainer/Brightness/Brightness").value = get_parent().get_node("Camera").environment.adjustment_brightness;
	get_node("OptionMenu/OptionsContainer/Contrast/Contrast").value = get_parent().get_node("Camera").environment.adjustment_contrast;
	get_node("OptionMenu/OptionsContainer/Saturation/Saturation").value = get_parent().get_node("Camera").environment.adjustment_saturation;
	if OS.window_fullscreen == true:
		get_node("OptionMenu/OptionsContainer/WindowMode").text = windowModeFullscreen;
	elif OS.window_fullscreen == false:
		get_node("OptionMenu/OptionsContainer/WindowMode").text = windowModeWindowed;



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

###Change DofBlur###
func _on_DoF_pressed():
	if get_parent().get_node("Camera").environment.dof_blur_far_enabled == true and get_parent().get_node("Camera").environment.dof_blur_near_enabled == true:
		get_node("OptionMenu/OptionsContainer/DoF").text = dofBlurOff;
		get_parent().get_node("Camera").environment.set_dof_blur_far_enabled(false);
		get_parent().get_node("Camera").environment.set_dof_blur_near_enabled(false);

	elif get_parent().get_node("Camera").environment.dof_blur_far_enabled == false and get_parent().get_node("Camera").environment.dof_blur_near_enabled == false:
		get_node("OptionMenu/OptionsContainer/DoF").text = dofBlurOn;
		get_parent().get_node("Camera").environment.set_dof_blur_far_enabled(true);
		get_parent().get_node("Camera").environment.set_dof_blur_near_enabled(true);

###Change Brightness###
func _on_Brightness_value_changed(value):
	get_parent().get_node("Camera").environment.adjustment_brightness = value;

###Change Contrast###
func _on_Contrast_value_changed(value):
	get_parent().get_node("Camera").environment.adjustment_contrast = value;

###Change Saturation###
func _on_Saturation_value_changed(value):
	get_parent().get_node("Camera").environment.adjustment_saturation = value;

###Change Window Mode###
func _on_WindowMode_pressed():
	if OS.window_fullscreen == true:
		get_node("OptionMenu/OptionsContainer/WindowMode").text = windowModeWindowed;
		OS.set_window_fullscreen(false);
	elif OS.window_fullscreen == false:
		get_node("OptionMenu/OptionsContainer/WindowMode").text = windowModeFullscreen;
		OS.set_window_fullscreen(true);
