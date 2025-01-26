extends Node2D
class_name SparaBolle

@export var projectile_scene: PackedScene
@onready var sprite: Sprite2D = $Sprite2D

var direction: Vector2
var prev_dir = Vector2.RIGHT

var is_enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction.x =  Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	if Input.is_action_just_pressed("shoot"):
		_shoot()
	_animate(direction)

func _shoot():
	if direction != Vector2.ZERO and is_enabled:
		var p: Projectile = projectile_scene.instantiate()
		p.direction = direction
		p.position = $ProjectilePoint.global_position
		#fa molto ridere ma vabbé
		get_parent().get_parent().get_parent().add_child(p)



func _animate(direction: Vector2):
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	rotation = direction.angle()
	#var different: bool = direction.x * prev_dir.x < 0
	#if direction.x >= 0:
		#scale.y *= -1
	#prev_dir = direction
