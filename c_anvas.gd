extends CanvasLayer

const x = preload("res://testscene.tscn")
@onready var launcher: TextureRect = $Launcher

func _ready() -> void:
	launcher.texture.current_frame = 0
	launcher.texture.one_shot = true
	

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(x)
