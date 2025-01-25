extends CharacterBody2D
class_name Player

@onready var bubble: MainBubble = $Bubble
@onready var sprite: AnimatedSprite2D = $Cat
@onready var collider: CollisionShape2D = $CollisionShape2D

@export var acceleration: float = 50
@export var friction_coef: float = 3
@export var max_speed: float = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction: Vector2
	direction.x =  Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	direction = direction.normalized()
	var friction =  -velocity.normalized() * friction_coef * velocity.length()/max_speed
	velocity += (acceleration * direction + friction) * delta
	velocity = velocity.normalized() * min(velocity.length(), max_speed)
	move_and_slide()
	_animate(direction)

func _animate(direction: Vector2) -> void:
	var radius = bubble.get_radius()
	var displacement = direction * (radius - 38)
	sprite.position = displacement
	collider.position = displacement
	
	#sceglie l'animazione
	if direction != Vector2.ZERO:
		sprite.animation = "walk"
	else:
		sprite.animation = "idle"
	
	#flippa in base alla direzione
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
