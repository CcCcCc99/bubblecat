extends Area2D
class_name MainBubble

@onready var sprite: Sprite2D = $Sprite2D

var invulnerable: bool = false
@export var max_o2: int = 50
@export var initial_o2: int = 20
var o2: int:
	set(value):
		o2 = clamp(value, 0, max_o2)
		self.scale = _calculate_scale()

@export var consumption_rate: int = 1

@export var min_scale: float = 0.8
@export var max_scale: float = 5

var original_modulation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	o2 = initial_o2
	original_modulation = sprite.modulate

func _on_oxigen_consumption_timeout() -> void:
	o2 -= consumption_rate

func _calculate_scale() -> Vector2:
	var delta = max_scale - min_scale
	var coefficent = float(o2)/float(max_o2)
	var scalar_scale = coefficent * delta + min_scale
	return Vector2.ONE * scalar_scale

func start_invulnerability():
	invulnerable = true
	$Invulnerability.start()
	sprite.modulate = Color.WHITE

func take_damage(damage: int):
	if not invulnerable:
		start_invulnerability()
		o2 -= damage

func end_invulnerability():
	invulnerable = false
	sprite.modulate = original_modulation

func get_radius() -> float:
	var circle: CircleShape2D = $CollisionShape2D.shape
	return circle.radius * scale.x
