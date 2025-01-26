extends Node

var armor_enabled: bool = false
var gun_level: int = 0
signal map_enabled

signal skill_points_updated
signal score_updated

var power_ups = [
	Callable(self, "enable_minimap"),
	Callable(self, "enable_armor"),
	Callable(self, "enable_gun"),
	#Callable(self, "power_up_gun"),
	#Callable(self, "power_up_gun"),
	Callable(self, "gain_score")
]
var power_up_index: int = 0:
	set(value):
		power_up_index = clamp(value, 0, power_ups.size())

var skill_points: int = 0:
	set(value):
		skill_points = value
		print("Punti abilità: ", skill_points)
		if skill_points >= target_for_level:
			skill_points -= target_for_level
			power_ups[power_up_index].call()
			power_up_index += 1
		skill_points_updated.emit()

var target_for_level: int = 4

var score: int = 0:
	set(value):
		score = value
		print("Punteggio: ",score)
		score_updated.emit()

func enable_minimap():
	map_enabled.emit()
	print("abilitata mappa")

func enable_armor():
	armor_enabled = true
	print("abilitate armature")

func enable_gun():
	gun_level = 1
	print("abilitate pistole")

func power_up_gun():
	gun_level += 1
	print("pistola livello: ", gun_level)

func gain_score():
	score += 3
	print("aggiunti 3 punti")
