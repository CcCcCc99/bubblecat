extends Node2D

@export var projectile_scene: PackedScene
var map: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		_shoot()

func _shoot():
	var direction: Vector2
	direction.x =  Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction != Vector2.ZERO:
		var p: Projectile = projectile_scene.instantiate()
		p.direction = direction
		p.position = $ProjectilePoint.position
		map.add_child(p)
