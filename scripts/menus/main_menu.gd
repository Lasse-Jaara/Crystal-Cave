extends Control
@onready var click_sound: AudioStreamPlayer = $click_sound

func _ready() -> void:
	if G.alku == 0:
		$CanvasLayer/fade.show()
		$CanvasLayer/fade/Timer.start()
		$CanvasLayer/fade/AnimationPlayer.play("fade_in")
		G.alku = 1
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	$CanvasLayer.hide()

func when_button_start_pressed() -> void:
	click_sound.play()
	get_tree().change_scene_to_file("res://scenes/ui/menus/levels_menu.tscn")

func when_button_quit_pressed() -> void:
	click_sound.play()
	get_tree().quit()


func when_button_options_pressed() -> void:
	click_sound.play()
	get_tree().change_scene_to_file("res://scenes/ui/menus/options.tscn")
	
