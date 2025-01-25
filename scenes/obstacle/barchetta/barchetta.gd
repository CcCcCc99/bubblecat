extends Obstacle

var direction: Vector2

func get_direction() -> Vector2:
	return (target.global_position - global_position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = position.direction_to(target.position)
	pass # Replace with function body.
