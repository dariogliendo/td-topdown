extends Node

const enemy = preload("res://enemy_scenes/slime.tscn")
var amount : int = 10;
var frequency : float = 1.0

signal wave_started(wave : Node)

func start():
	wave_started.emit(self)
	
func end():
	print("End")
