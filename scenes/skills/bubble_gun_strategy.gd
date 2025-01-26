extends Node

const PISTOLA_PATH = "res://assets/sprites/pistola.png"

var gun: SparaBolle

func _ready() -> void:
	gun = get_parent().get_node("Cat").get_node("SparaBolle")
	gun.is_enabled = true

func _on_timer_timeout() -> void:
	gun.is_enabled = false
	queue_free()
