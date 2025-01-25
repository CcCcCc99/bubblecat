extends Area2D

@export var points: int = 1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("Raccoloto: ", points)
		PointsManager.skill_points += points
		queue_free()
