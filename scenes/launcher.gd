extends TextureRect

@export var menu: Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("transition_in")

func _on_timer_timeout() -> void:
	menu.show_menu()
	queue_free()
