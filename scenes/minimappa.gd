extends NinePatchRect

@export var margin: float = 60.
@export var vasca_size: Vector2 = Vector2(6971.,3841.)

const PLAYER_MARKER = preload("res://scenes/minimappa/player_marker.tscn")
const REGEN_BUBBLE_MARKER = preload("res://scenes/minimappa/regen_bubble_marker.tscn")

@onready var minimap_size: Vector2 = size - Vector2(margin, margin)
@onready var minimap_center: Vector2 = size/2.

var player: Player
var player_sprite: Sprite2D
var regen_bubble_sprites: Array[Sprite2D]

func get_minimap_pos_from_vasca_pos(vasca_pos: Vector2) -> Vector2:
	return minimap_center + (vasca_pos/(vasca_size/2.)) * (minimap_size/2.)

func _ready() -> void:
	var regen_bubbles: Array[Node] = get_tree().get_nodes_in_group("RegenBubble")
	print(regen_bubbles.size())
	for index in regen_bubbles.size():
		var new_sprite: Sprite2D = REGEN_BUBBLE_MARKER.instantiate()
		new_sprite.position = get_minimap_pos_from_vasca_pos((regen_bubbles[index] as Node2D).global_position)
		add_child(new_sprite)
		regen_bubble_sprites.append(new_sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_sprite:
		player_sprite.position = get_minimap_pos_from_vasca_pos(player.global_position)
	
	var regen_bubbles: Array[Node] = get_tree().get_nodes_in_group("RegenBubble")
	for index in regen_bubbles.size():
			var bubble: Node2D = regen_bubbles[index] as Node2D
			regen_bubble_sprites[index].position = get_minimap_pos_from_vasca_pos(bubble.global_position)
			regen_bubble_sprites[index].modulate = Color("#016093") if not bubble.collectable else Color.WHITE

func set_player(_player: Player):
	player = _player
	var pl_sprite: Sprite2D = PLAYER_MARKER.instantiate()
	pl_sprite.position = get_minimap_pos_from_vasca_pos(player.global_position)
	add_child(pl_sprite)
	player_sprite = pl_sprite
