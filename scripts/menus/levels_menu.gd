extends Control

@onready var click_sound: AudioStreamPlayer = $click_sound
@onready var time: Label = $MarginContainer/MarginContainer/VBoxContainer2/Label
@onready var time_2: Label = $MarginContainer/MarginContainer/VBoxContainer3/Label
@onready var time_3: Label = $MarginContainer/MarginContainer/VBoxContainer4/Label



func when_pressed_button_exit() -> void:
	#if G.last_scene == "main_menu":
	click_sound.play()
	get_tree().change_scene_to_file("res://scenes/ui/menus/main_menu.tscn")
#	elif G.last_scene == "pause_menu":
#		click_sound.play()
#		get_tree().change_scene_to_file("res://scenes/ui/menus/pause_menu.tscn")

func when_pressed_button_level_1() -> void:
	click_sound.play()
	G.last_scene = "level_1"
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func when_pressed_button_level_2() -> void:
	click_sound.play()
	G.last_scene = "level_2"
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func when_pressed_button_level_3() -> void:
	click_sound.play()
	#G.last_scene = "level_3"
	#get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	
		
func _process(_delta: float) -> void:
	if G.best_time_level_1 == 5000.1:
		time.text = "best time:   " + "no value yet"
	if G.best_time_level_1 != 5000.1:
		time.text = "best time:   " + str(G.best_time_level_1) + " s"
	if G.best_time_level_2 == 5000.1:
		time_2.text = "best time:   " + "no value yet"
	if G.best_time_level_2 != 5000.1:
		time_2.text = "best time:   " + str(G.best_time_level_2) + " s"
	if G.best_time_level_3 == 5000.1:
		time_3.text = "best time:   " + "no value yet"
	if G.best_time_level_3 != 5000.1:
		time_3.text = "best time:   " + str(G.best_time_level_3) + " s"	
