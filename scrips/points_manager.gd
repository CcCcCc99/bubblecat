extends Node

var armor_enabled: bool = true

signal skill_points_updated
signal score_updated

var skill_points: int = 0:
	set(value):
		skill_points = value
		print("Punti abilità: ", skill_points)
		emit_signal("skill_points_updated")

var score: int = 0:
	set(value):
		score = value
		print("Punteggio: ",score)
		emit_signal("score_updated")
