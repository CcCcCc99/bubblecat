extends Area2D
class_name FinishArea

@export var points: int = 10

signal arrived

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		PointsManager.score += points
		emit_signal("arrived")

func enable():
	print("abilitato")

func disable():
	print("disabilitato")
