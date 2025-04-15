extends Control

@onready var click_sound: AudioStreamPlayer = $click_sound

func when_back_options_button_pressed() -> void:
	if G.last_scene == "main_menu":
		click_sound.play()
		get_tree().change_scene_to_file("res://scenes/ui/menus/main_menu.tscn")
	elif G.last_scene == "pause_menu":
		click_sound.play()
		get_tree().change_scene_to_file("res://scenes/ui/menus/pause_menu.tscn")


func _process(_delta: float) -> void:
	if G.x == 1:
		$MarginContainer/MarginContainer/VBoxContainer/CheckButton.button_pressed = true
	else:
		$MarginContainer/MarginContainer/VBoxContainer/CheckButton.button_pressed = false





func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		G.x = 1
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		G.x = 0
