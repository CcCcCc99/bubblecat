extends TextureRect

@export var menu: Control
@export var manager: GameManager

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if menu:
		animation_player.play("transition_in")

func _on_timer_timeout() -> void:
	if menu:
		menu.show_menu()
	if manager:
		manager.start_game()
	queue_free()
