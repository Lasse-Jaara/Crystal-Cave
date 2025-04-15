extends Node2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.is_in_group("player"): # katsoo onko ryhmässä "pelaaja"
		if G.vahinkoittunut == false:
			G.pelaajan_healt -= 10
		cpu_particles_2d.emitting = true
		$AnimatedSprite2D.play("hitted")
		
	
