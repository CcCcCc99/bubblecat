extends Area2D
class_name  Obstacle

@export var speed: float = 200
@export var target: Node2D
@export var damage: int = 5

var is_captured = false

func get_direction() -> Vector2:
	return Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_captured:
		position += get_direction() * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if is_captured:
		PointsManager.score += 1
		queue_free()
	if area is MainBubble and not is_captured:
		var b = area as MainBubble
		b.take_damage(damage)

func _on_despawn_timeout() -> void:
	queue_free()

func capture() -> void:
	$Bubble.show()
	is_captured = true
