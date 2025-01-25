extends Area2D

const ARMATURA_STATEGY = preload("res://scenes/skills/armatura_stategy.tscn")

@export var collectable: bool = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player and collectable:
		var p = body as Player
		var armatura_stategy = ARMATURA_STATEGY.instantiate()
		p.add_child(armatura_stategy)
		queue_free()
