extends Node2D
@onready var bar: ProgressBar = $CanvasLayer/ProgressBar


var numero = 100
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if G.pelaajan_healt != numero:
		numero = G.pelaajan_healt
		bar.value = numero
