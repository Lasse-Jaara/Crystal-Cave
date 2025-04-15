extends CharacterBody2D
var nopeus = 60
@onready var ray_cast_2d_oikea: RayCast2D = $RayCast2D_oikea
@onready var ray_cast_2d_vasen: RayCast2D = $RayCast2D_vasen
@export_range(10, 100) var isku = 10
@onready var ray_cast_2d_alas: RayCast2D = $RayCast2D_alas
@onready var juoksu: CPUParticles2D = $juoksu
var painovoima = ProjectSettings.get_setting("physics/2d/default_gravity")


var x = 0
#func handle_hit():
#	print("osui")
var suunta_alas = 0
var suunta = 1
var y = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	x = randf_range(60,110)
	nopeus = x
	var alfa = 0.00
	var z = 0
	while z < x:
		alfa += 0.05
		if x == z:
			y += alfa
		z += 1
	
	$AnimatedSprite2D.speed_scale += y

	
func _physics_process(delta: float) -> void:
	if ray_cast_2d_oikea.is_colliding():
		suunta = -1
		$AnimatedSprite2D.flip_h = true 
	if ray_cast_2d_vasen.is_colliding():
		suunta = 1
		$AnimatedSprite2D.flip_h = false
	if ray_cast_2d_alas.is_colliding() == false:
		suunta_alas = 1
	else:
		suunta_alas = 0
	position.x += suunta * nopeus * delta
	if not is_on_floor():  # Painovoima, jos ei olla maassa.
		velocity.y += painovoima * delta  # Muuttaa Y-nopeutta painovoiman perusteella.
	move_and_slide()
#position.y += suunta_alas * nopeus * delta




var voiko_hyökätä = true




func odotus_aika_seuravaan_iskuun():
	var timer: Timer = Timer.new() # luodaan uusi timeri
	add_child(timer) # configure the timer
	timer.wait_time = 0.85
	timer.one_shot = true
	timer.timeout.connect(kun_aika_loppuu)
	timer.start()

func kun_aika_loppuu() -> void:
	voiko_hyökätä = true
	
	
func _on_area_2d_body_entered(body: Node2D) -> void: # valvoo onko enmy area 2d tuleeko joku
	if body.is_in_group("player"): # katsoo onko ryhmässä "pelaaja"
		if voiko_hyökätä == true:
			if G.vahinkoittunut == false:
				G.pelaajan_healt -= isku
				voiko_hyökätä = false
		odotus_aika_seuravaan_iskuun()
