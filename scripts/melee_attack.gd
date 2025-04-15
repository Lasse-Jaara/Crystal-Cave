extends Area2D
@onready var animation: AnimationPlayer = $AnimationPlayer

#func attack():
	#animation.play("collision_swtich")
	



#func _on_body_entered(body: Node2D) -> void:
	#if body.has_method("handle_hit"):  # has method  din avulla voidaan tarkastella onko jollain scriptillä tai esim scenellä tiettyä funktiota
	#	body.handle_hit()
