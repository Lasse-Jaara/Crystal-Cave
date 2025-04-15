extends CharacterBody2D
@export_range(-1, 1000) var kävely_nopeus = 150  # Perus kävelynopeus.
@export_range(-1, 1000) var juoksu_nopeus = 230  # Juoksunopeus.
@export_range(-1000, 1000) var hyppy_voima = -400.0  # Hyppyvoima (negatiivinen Y tarkoittaa ylöspäin).
@export_range(0, 1) var hidasta_hypyn_irrotuksessa = 0.3  # Hidastaa, kun hyppy vapautetaan kesken.
@export_range(0, 3) var kiihtyvyys = 0.1  # Kiihtyvyyden kerroin.
@export_range(0, 3) var hidastuvuus = 0.1  # Hidastuvuuden kerroin.
@export_range(-10, 200) var seinä_hyppy_apu = 43  # Seinähypyn apuvoima.
@onready var coyote_hyppy_ajastin: Timer = $Coyote_hyppy_ajastin 
@onready var animations = $animated_sprite

@onready var jump: AudioStreamPlayer = $Jump

@onready var audio_stream_player: AudioStreamPlayer = $hurt # hit / hurt
@onready var deaht: AudioStreamPlayer = $deaht # death
@onready var hurt_timer: Timer = $hurt_timer
@onready var kuoleminen_particle: CPUParticles2D = $CPUParticles2D
#@onready var melee_attack_timer: Timer = $melee_attack_timer

@onready var tupla_hyppy_particle: CPUParticles2D = $tupla_hyppy
@onready var seinä_hyppy_particle: CPUParticles2D = $"seinä_hyppy"
@onready var seinä_hyppy_particle_oikea: CPUParticles2D = $"seinä_hyppy_oikea"
@onready var juoksu_particle: CPUParticles2D = $juoksu
@onready var hyppy_particle: CPUParticles2D = $hyppy


var painovoima = ProjectSettings.get_setting("physics/2d/default_gravity")

#----------------------------------------------------------------------------------------------------------#
var numero: int = 100
var pystyykö_liikkua := true
var x = 0

func timer_vahinkoittuminen():
	hurt_timer.start()


func _on_hurt_timer_timeout() -> void:
	G.vahinkoittunut = false



func healt():
	if G.vahinkoittunut == false:
		if G.pelaajan_healt < numero:
			kerta = 0
			# knocback when hurt
			if velocity.x <= -0:
				velocity.x = (velocity.x +260)
			elif velocity.x >= 0:
					velocity.x = (velocity.x -260)
			if velocity.y <= -0:
				velocity.y = (velocity.y +260)
			elif velocity.y >= 0:
				velocity.y = (velocity.y -260)
			#-------------------------------#
			G.vahinkoittunut = true
			if velocity.x > 0 or velocity.x < -0:
				animations.play("vahinkoittuminen")
			else:
				animations.play("vahinkoittuminen_eestä")
			numero = G.pelaajan_healt
			audio_stream_player.play()
			timer_vahinkoittuminen()
			
	if G.pelaajan_healt <= 0:
		while x == 0:
			deaht.play()
			x = 1
		kuolit()

func kuolit():
	pystyykö_liikkua = false
	animations.play("empty")
	kuoleminen_particle.emitting = true
	timer_kuoleminen()



func timer_kuoleminen():
	var timer: Timer = Timer.new() # luodaan uusi timeri
	add_child(timer) # configure the timer
	timer.wait_time = 2
	timer.one_shot = true
	timer.timeout.connect(kun_aika_loppuu_kuoleminen)
	timer.start()

var kerta = 0
func kun_aika_loppuu_kuoleminen() -> void:
	G.pelaajan_healt = 100
	G.crystals = 0
	if kerta == 0:
		get_tree().call_deferred("reload_current_scene")
		kerta = 1

#----------------------------------------------------------------------------------------------------------#
# Suoritetaan koko ajan, ei tarvitse kutsua – Godot kutsuu automaattisesti fysiikkaframeissa.
func _physics_process(delta):
	suoritus_painovoima(delta)
	if pystyykö_liikkua == true:
		suoritus_liikkuminen()
	if pystyykö_liikkua == true:
		suoritus_syöttö()
	
	healt()
	var oli_maassa = is_on_floor() # muistaa ollaanko maassa
	if pystyykö_liikkua == true:
		move_and_slide() # Liikuttaa hahmoa velocityn avulla.
	if pystyykö_liikkua == true:
		suoritus_animatiot()
		
	var justiinsa_lähdettiin_reunalta = oli_maassa and not is_on_floor() and velocity.y >= 0 # jos oltiin maassa ja ei olla enään ja velocity.y >= 0 meinaa että hahmo on liikkumassa alas päin
	if justiinsa_lähdettiin_reunalta:
		coyote_hyppy_ajastin.start()







  # Hakee painovoiman projektiasetuksista, jotta se synkronoituu muiden fysiikkabodyjen kanssa

func suoritus_painovoima(delta):
	if not is_on_floor():  # Painovoima, jos ei olla maassa.
		velocity.y += painovoima * delta  # Muuttaa Y-nopeutta painovoiman perusteella.

#----------------------------------------------------------------------------------------------------------#

var nopeus = float(kävely_nopeus)

func suoritus_liikkuminen():
	var suunta = float(Input.get_axis("vasen", "oikea"))  # Varmistetaan, että suunta on float.
	if suunta != 0.0: # voidaan ilmaista myös   if suunta:  tämä tarkistaa myös onko arvo jokin eri kuin nolla
		velocity.x = lerp(float(velocity.x), suunta * nopeus, float(kiihtyvyys))  # Kiihtyy kohti tavoitenopeutta.
	else:
		velocity.x = lerp(float(velocity.x), 0.0, float(hidastuvuus))  # Hidastuu, kun ei ole syötettä.

#----------------------------------------------------------------------------------------------------------#

	

func suoritus_animatiot():
	if is_on_floor() and !G.vahinkoittunut:
		if !velocity:
			animations.play("elo")
		if velocity:
			#juoksu_particle.emitting = true
			animations.play("juoksu")
	elif !is_on_floor() and !G.vahinkoittunut:
		if velocity.y > 0:
			animations.play("putoaminen")
		else:
			animations.play("hyppy")	
		
	animations.flip_h = velocity.x < 0
	if Input.is_action_pressed("vasen"):
		animations.flip_h = true


	
#----------------------------------------------------------------------------------------------------------#
var pystyykö_tupla_hypätä = true 
var pystyykö_seinä_hypätä = 0  # Mahdollistaa seinähypyn.


func suoritus_syöttö():
	if not is_on_floor() and not is_on_wall():
		pystyykö_seinä_hypätä = 0
	if Input.is_action_just_pressed("hyppy"):
		hyppy_päätös()
	if Input.is_action_just_released("hyppy") and velocity.y < 0:
		velocity.y *= hidasta_hypyn_irrotuksessa  # Hidastaa ylöspäin liikettä, kun hyppy vapautetaan.	
	elif Input.is_action_pressed("juoksu"):	# Nopeuden säätö syötteen perusteella.
		nopeus = float(juoksu_nopeus)
		juoksu_particle.emitting = true
	else:
		nopeus = float(kävely_nopeus)

#----------------------------------------------------------------------------------------------------------#




func hyppy_päätös():
	if is_on_wall() == true:
		if pystyykö_seinä_hypätä != 2:
			seinä_hyppy()
	elif is_on_floor() or coyote_hyppy_ajastin.time_left > 0.0:
		hyppy()
	elif pystyykö_tupla_hypätä == true:
		tupla_hyppy()

func hyppy():
	hyppy_particle.emitting = true
	velocity.y = hyppy_voima
	jump.play()
	pystyykö_tupla_hypätä = true  # Tuplahyppy mahdollistetaan.
	pystyykö_seinä_hypätä = 0

func tupla_hyppy():
	if velocity.x >= 0:
		velocity.x = (velocity.x +1000)
	elif velocity.x <= -0:
			velocity.x = (velocity.x -1000)
	tupla_hyppy_particle.emitting = true
	velocity.y = hyppy_voima
	jump.play()
	pystyykö_tupla_hypätä = false  # Tuplahyppy estetään käytön jälkeen.
	pystyykö_seinä_hypätä = 0

func seinä_hyppy():
	jump.play()
	if velocity.x >= 0:
		seinä_hyppy_particle_oikea.emitting = true
		velocity.x = (velocity.x +200)
	elif velocity.x <= -0:
			seinä_hyppy_particle.emitting = true
			velocity.x = (velocity.x -200)
	
	velocity.y = hyppy_voima + seinä_hyppy_apu
	pystyykö_tupla_hypätä = true  # Mahdollistaa tuplahypyn seinähypyn jälkeen.
	pystyykö_seinä_hypätä += 1

#----------------------------------------------------------------------------------------------------------#

#@onready var weapon: Area2D = $Area2D


#func _unhandled_input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("melee_attack"):
		#weapon.attack()




#var vihollinen_ulottuvilla = false
#var voi_hyökätä = true

#func _on_area_2d_body_entered(body: Node2D) -> void:
#	if Input.is_action_pressed("melee_attack"):
#		if body.has_method("handle_hit"):
#			vihollinen_ulottuvilla = true
#			if voi_hyökätä == true:
#				voi_hyökätä = false
#				melee_attack_timer.start()
#				body.handle_hit()
#		else:
#			vihollinen_ulottuvilla = false


#func _on_melee_attack_timer_timeout() -> void:
#	voi_hyökätä = true
	
