extends Area2D
class_name  Obstacle

@export var speed: float = 200
@export var target: Node2D
@export var damage: int = 5

func get_direction() -> Vector2:
	return Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += get_direction() * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is MainBubble:
		var b = area as MainBubble
		b.take_damage(damage)


func _on_despawn_timeout() -> void:
	queue_free()
