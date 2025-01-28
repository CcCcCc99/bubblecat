extends Control

const TESTSCENE: PackedScene = preload("res://c_anvas.tscn")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var play_button: CustomButton = $PlayButton


func show_menu():
	show()
	play_button.grab_focus()
	audio_stream_player.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(TESTSCENE)

func _on_exit_pressed() -> void:
	get_tree().quit()
