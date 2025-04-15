extends Node2D
@onready var labelli: Label = $CanvasLayer/VBoxContainer/Label

#@onready var labelli: Label = get_node("$CanvasLayer/VBoxContainer/Label")

var numero_str = ""
var numero_2 = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if G.crystals != numero_2:
		numero_2 = G.crystals
		numero_str = str(numero_2) + " x"
		labelli.text = numero_str
		
