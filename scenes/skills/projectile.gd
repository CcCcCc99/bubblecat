extends Area2D
class_name Projectile

var direction: Vector2
@export var speed: float = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area is Obstacle:
		var o = area as Obstacle
		o.capture()
		queue_free()
