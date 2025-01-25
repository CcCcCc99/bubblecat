extends Area2D
class_name StartLine

@export var malus: int = 5

var finish: FinishArea

func _ready() -> void:
	finish = get_node("FinishArea") 

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		finish.arrived.connect(finish.enable)
		$TimeToFinish.start()

func _on_time_to_finish_timeout() -> void:
	finish.disable()
	PointsManager.score -= malus
	$Cooldown.start()
