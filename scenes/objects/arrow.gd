extends Node2D
class_name Arrow

var target: Node2D

func _ready() -> void:
	disable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target != null:
		look_at(target.global_position)

func enable(t):
	target = t
	show()

func disable():
	target = null
	hide()
	
