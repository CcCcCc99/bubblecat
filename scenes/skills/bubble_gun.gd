extends Area2D

@export var scene: PackedScene

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var p = body as Player
		var armatura_stategy = scene.instantiate()
		p.add_child(armatura_stategy)
		queue_free()
