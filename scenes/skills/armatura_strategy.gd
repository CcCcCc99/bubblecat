extends Node

const ARMOR_SPRITE = preload("res://scenes/skills/armor_sprite.tscn")

var player: Player
var armor_sprite_node: Sprite2D

func _ready() -> void:
	player = get_parent()
	player.bubble.invulnerable = true
	armor_sprite_node = ARMOR_SPRITE.instantiate()
	player.bubble.add_child(armor_sprite_node)

func _on_timer_timeout() -> void:
	# se muori con l'invulnerabilità a dosso è un problema
	# da sistemare
	player.bubble.death
	player.bubble.invulnerable = false
	armor_sprite_node.queue_free()
	queue_free()
