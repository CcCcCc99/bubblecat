extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_score()
	PointsManager.score_updated.connect(_update_score)
	_update_progrssbar()
	PointsManager.skill_points_updated.connect(_update_progrssbar)
	$Minimappa.hide()
	PointsManager.map_enabled.connect($Minimappa.show)

func _update_score() -> void:
	$Score.text = str(PointsManager.score)

func _update_progrssbar() -> void:
	$ProgressBar.value = PointsManager.skill_points
	$ProgressBar.max_value = PointsManager.target_for_level
