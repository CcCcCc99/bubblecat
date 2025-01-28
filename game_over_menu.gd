extends Control


@onready var score_value: Label = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/ScoreValue
@onready var high_score_value: Label = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer3/HighScoreValue
@onready var retry_button: TextureButton = $PanelContainer/MarginContainer/VBoxContainer/VBoxContainer2/RetryButton

var highscore:
	set(value):
		high_score_value.text = str(value)
		highscore = value
var save_file_path = "user://highscore.save"

func _ready() -> void:
	PointsManager.score_updated.connect(_update_score)
	load_score()
	_update_score()
	
func show_score():
	show()
	retry_button.grab_focus()
	save_score()

func save_score():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	file.store_var(highscore)
	file.close()

func load_score():
	if FileAccess.file_exists(save_file_path):
		var file = FileAccess.open(save_file_path, FileAccess.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0

func _update_score():
	score_value.text = str(PointsManager.score)
	if PointsManager.score > highscore:
		highscore = PointsManager.score

func _on_retry_button_pressed() -> void:
	PointsManager.restart()
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
