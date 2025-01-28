extends Node

const ARMOR_SPRITE = preload("res://scenes/skills/armor_sprite.tscn")
const ARMATURA_PATH = "res://assets/skills/armatura.png"

var player: Player
var armor_sprite_node: Sprite2D

func _ready() -> void:
	player = get_parent()
	player.bubble.invulnerable_count += 1
	armor_sprite_node = ARMOR_SPRITE.instantiate()
	player.bubble.add_child(armor_sprite_node)


func _on_timer_timeout() -> void:
	if not player.bubble.is_dead:
		player.bubble.invulnerable_count -= 1
		armor_sprite_node.queue_free()
		queue_free()
