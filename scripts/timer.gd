extends Node2D
@onready var labelli: Label = $CanvasLayer/VBoxContainer/Label

#@onready var labelli: Label = get_node("$CanvasLayer/VBoxContainer/Label")
@onready var timer: Timer = $Timer

var numero_str = ""
var numero_2 = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	timer.start()
func _process(_delta: float) -> void:
	var x = 0
	x = str($Timer.get_time_left()).pad_decimals(1)
	numero_2 = 5000.0 - float(x) 
	G.time = snapped(numero_2, 0.1)
	#print(str(G.time) + "aaa")
	numero_str = str(snapped(numero_2, 0.1)) + " s"
	labelli.text = numero_str
