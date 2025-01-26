extends CanvasLayer

const x = preload("res://testscene.tscn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(x)
