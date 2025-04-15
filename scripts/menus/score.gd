extends Control
@onready var labelli: Label = $MarginContainer2/MarginContainer2/MarginContainer/VBoxContainer/Label
@onready var time: Label = $MarginContainer2/MarginContainer2/MarginContainer2/VBoxContainer/time

#@onready var labelli: Label = get_node("$CanvasLayer/VBoxContainer/Label")

var numero_str = ""
var numero_2 = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _ready() -> void:
	time.text = str(G.time) + " s"
	labelli.text = str(G.crystals) + " x"

func _process(_delta: float) -> void:
	#if G.crystals != numero_2:
		pass
		#time.text = str(G.time) + " s"



@onready var click_sound: AudioStreamPlayer = $click_sound


var kerta = 0
func when_pressed_button_again() -> void:
	click_sound.play()
	G.pelaajan_healt = 100
	G.crystals = 0
	#if kerta == 0:
		#get_tree().call_deferred("reload_current_scene")
		#kerta = 1
	if G.last_scene == "level_1":
		get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	if G.last_scene == "level_2":
		get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")
	if G.last_scene == "level_3":
		pass



func when_pressed_exit_button() -> void:
	G.pelaajan_healt = 100
	G.crystals = 0
	#if kerta == 0:
		#get_tree().call_deferred("reload_current_scene")
		#kerta = 1
	click_sound.play()
	G.last_scene = "main_menu"
	get_tree().change_scene_to_file("res://scenes/ui/menus/main_menu.tscn")
