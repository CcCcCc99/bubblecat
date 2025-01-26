extends Area2D
class_name FinishArea

@export var points: int = 10

signal arrived

func _ready() -> void:
	disable()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		PointsManager.score += points
		emit_signal("arrived")
		disable()

func enable():
	$CollisionShape2D.set_deferred("disabled", false)
	show()

func disable():
	$CollisionShape2D.set_deferred("disabled", true)
	hide()
