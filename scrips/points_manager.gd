extends Node

var armor_enabled: bool = false
var gun_level: int = 0

signal map_enabled
signal skill_points_updated
signal score_updated

func restart():
	power_up_index = 0
	skill_points = 0
	score = 0
	armor_enabled = 0
	gun_level = 0

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
		if value >= target_for_level:
			skill_points = 0
			power_ups[power_up_index].call()
			power_up_index += 1
		else:
			skill_points = value
		skill_points_updated.emit()

var target_for_level: int = 4

var score: int = 0:
	set(value):
		score = value
		score_updated.emit()

func enable_minimap():
	map_enabled.emit()

func enable_armor():
	armor_enabled = true

func enable_gun():
	gun_level = 1

# TODO: To be implemented
func power_up_gun():
	gun_level += 1

func gain_score():
	score += 3
