extends Area2D
class_name MainBubble

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var invulnerability_timer: Timer = $Invulnerability

signal death

var invulnerable_count: int = 0:
	set(value):
		var counter_label: Label = get_tree().get_nodes_in_group("InvulnerabilityCounter")[0] as Label
		counter_label.text = str(value)
		invulnerable_count = value
var is_dead = false
@export var max_o2: int = 50
@export var initial_o2: int = 20
var o2: int:
	set(value):
		o2 = clamp(value, 0, max_o2)
		self.scale = _calculate_scale()
		if not is_dead and o2 <= 0:
			emit_signal("death")
			is_dead=true

@export var consumption_rate: int = 1

@export var min_scale: float = 0.8
@export var max_scale: float = 5

var original_modulation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	o2 = initial_o2
	invulnerable_count = 0
	original_modulation = sprite.modulate

func _on_oxigen_consumption_timeout() -> void:
	o2 -= consumption_rate

func _calculate_scale() -> Vector2:
	var delta = max_scale - min_scale
	var coefficent = float(o2)/float(max_o2)
	var scalar_scale = coefficent * delta + min_scale
	return Vector2.ONE * scalar_scale

func start_invulnerability():
	invulnerable_count += 1
	invulnerability_timer.start()
	sprite.modulate = Color.WHITE

func take_damage(damage: int):
	if invulnerable_count == 0:
		start_invulnerability()
		o2 -= damage

func end_invulnerability():
	invulnerable_count -= 1
	sprite.modulate = original_modulation

func get_radius() -> float:
	var circle: CircleShape2D = $CollisionShape2D.shape
	return circle.radius * scale.x

func _on_death() -> void:
	sprite.play("pop")

func _on_sprite_2d_animation_finished() -> void:
	if sprite.animation == "pop":
		hide()
		await get_tree().create_timer(1.5).timeout
		get_tree().get_nodes_in_group("gameovermenu")[0].show_score()
		for audio in get_tree().get_nodes_in_group("audio"):
			if (not audio.playing) and audio.name == "AudioGameOver":
				audio.play()
