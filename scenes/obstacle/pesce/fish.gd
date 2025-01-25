extends Area2D
class_name Fish

@export var newspeed: float = 200
@export var target: Node2D
@export var damage: int = 5

# Realizzare due comportamenti diversi per il pesce.
# 1) Come per la barca :D
# 2) Aumenta la velocita'
# Nota bene: sta dando problemi. Dovrebbe avere lo stesso comportamento della barca per ora, ma non sta funzionando.
func get_direction() -> Vector2:
	return (target.global_position - global_position).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += get_direction() * newspeed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is MainBubble:
		var b = area as MainBubble
		b.take_damage(damage)


func _on_despawn_timeout() -> void:
	queue_free()
