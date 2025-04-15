extends Node2D

func _on_area_2d_body_entered(_body: Node2D) -> void:
	var timer: Timer = Timer.new() # luodaan uusi timeri
	add_child(timer) # configure the timer
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.timeout.connect(kun_aika_loppuu)
	timer.start()

func kun_aika_loppuu() -> void:
	G.crystals = 0
	G.pelaajan_healt = 0
