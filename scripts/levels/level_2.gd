extends Node2D
@onready var pause_menu: Control = $CanvasLayer/pause
	
	
	
var game_paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.crystals = 0
	G.pelaajan_healt = 100
	$CanvasLayer/fade.show()
	$CanvasLayer/fade/Timer.start()
	$CanvasLayer/fade/AnimationPlayer.play("fade_in")




func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esk"):
		game_paused = !game_paused
		if game_paused:
			Engine.time_scale = 0
			
			G.last_scene = "pause_menu"
			
			pause_menu.visible = true
		else:
			Engine.time_scale = 1
			pause_menu.visible = false
		get_tree().root.get_viewport().set_input_as_handled()
