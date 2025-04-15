extends Control
@onready var click_sound: AudioStreamPlayer = $click_sound


func when_button_continue_pressed() -> void:
	click_sound.play()
	Engine.time_scale = 1
	$".".visible = false
	

func when_button_exit_pressed() -> void:
	click_sound.play()
	Engine.time_scale = 1
	$".".visible = false
	G.last_scene = "main_menu"
	get_tree().change_scene_to_file("res://scenes/ui/menus/main_menu.tscn")	
