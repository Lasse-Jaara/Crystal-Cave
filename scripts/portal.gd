extends Node2D
@onready var timer: Timer = $Timer

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("player"):
		#get_tree().call_deferred("reload_current_scene")
		timer.start()
var kerta = 0
var x  = 0.0
func when_timer_runs_ot_of_TIME() -> void:
	x = G.time
	
	print(get_tree().current_scene.name)
	
	# ---ei toimi jonkun syystä >:(
	#if get_tree().current_scene.name == "level_2":
	#	print("1")
	#	if G.best_time_level_2 > x:
		#	G.best_time_level_2 = x
	
	if get_tree().current_scene.name == "level_1":
		if G.best_time_level_1 > x:
			G.best_time_level_1 = x
			
	else:
		G.best_time_level_2 = x
		
	get_tree().change_scene_to_file("res://scenes/ui/menus/score.tscn")
