extends Node2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var cpu_particles: CPUParticles2D = $CPUParticles2D

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("player"):
		$Area2D.queue_free()
		G.crystals += 1
		$AnimatedSprite2D.queue_free()
		audio_stream_player.play()
		cpu_particles.emitting = true
		if G.pelaajan_healt < 100:
			G.pelaajan_healt += 10


#func _on_audio_stream_player_2d_finished() -> void:
	#	$".".queue_free()

func _on_cpu_particles_2d_finished() -> void:
	$".".queue_free()
