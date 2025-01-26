extends CharacterBody2D
class_name Player

@onready var bubble: MainBubble = $Bubble
@onready var sprite: AnimatedSprite2D = $Cat
@onready var collider: CollisionShape2D = $CollisionShape2D

@export var cat_speed: float = 400
@export var acceleration: float = 50
@export var friction_coef: float = 3
@export var max_speed: float = 300

var tween: Tween
var is_alive: bool = true

func  _ready() -> void:
	tween = get_tree().create_tween()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_alive:
		var direction: Vector2
		direction.x =  Input.get_axis("move_left","move_right")
		direction.y = Input.get_axis("move_up", "move_down")
		direction = direction.normalized()
		var friction =  -velocity.normalized() * friction_coef * velocity.length()/max_speed
		velocity += (acceleration * direction + friction) * delta
		velocity = velocity.normalized() * min(velocity.length(), max_speed)
		move_and_slide()
		
		sprite.position += cat_speed * direction * delta
		collider.position += cat_speed * direction * delta

		_animate(direction)

var prev_dir: Vector2 = Vector2.ZERO


func _animate(direction: Vector2) -> void:
	var radius = bubble.get_radius()
	var displacement = direction * (radius - 38)
	var distance = sprite.position.distance_to(Vector2.ZERO)
	if distance > displacement.length():
		sprite.position = displacement
		collider.position = displacement
	
	#sceglie l'animazione
	if direction != Vector2.ZERO:
		sprite.animation = "walk"
	else:
		sprite.animation = "idle"
	
	if direction.x > 0:
		sprite.scale.x = 1
	elif direction.x < 0:
		sprite.scale.x = -1

func _on_bubble_death() -> void:
	is_alive = false
	$Swimming.show()
