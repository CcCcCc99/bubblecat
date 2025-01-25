extends Area2D

@export var cooldown: int = 70
@export var regen: int = 20

@onready var sprite = $Sprite2D

@export var collectable: bool = true:
	set(value):
		collectable = value
		if collectable:
			sprite.play("default")
		else:
			sprite.play("pop")

func _ready() -> void:
	$Cooldown.wait_time = cooldown
	sprite.play("default")

func _on_cooldown_timeout() -> void:
	collectable = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player and collectable:
		var p = body as Player
		var b: MainBubble = p.bubble
		b.o2 += regen
		collectable = false
		$Cooldown.start()

func _on_sprite_2d_animation_finished() -> void:
	if sprite.animation == "pop":
		sprite.play("wait")
