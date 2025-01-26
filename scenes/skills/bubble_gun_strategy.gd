extends Node

@export var gun_scene: PackedScene
var instance: Node2D
var map: Node2D
var sprite: AnimatedSprite2D

func _ready() -> void:
	map = get_parent()
	sprite = get_parent().get_node("Cat")
	instance = gun_scene.instantiate()
	instance.map = map
	sprite.add_child(instance)

func _on_timer_timeout() -> void:
	instance.queue_free()
	queue_free()
