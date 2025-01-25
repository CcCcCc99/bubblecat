extends Node

var armor_enabled: bool = true

signal points_updated

var points: int = 0:
	set(value):
		points = value
		print("Punteggio: ", points)
		emit_signal("points_updated")
