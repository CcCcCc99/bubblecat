extends Node

@export var player_scene: PackedScene
@export var skill_point_scene: PackedScene
@export var skill_scene: PackedScene
@export var obstacle_scene: PackedScene
var player: Player

@export var min_spawn_distance: int = 800
@export var max_spawn_distance: int = 1200

@export var max_points_in_map: int = 50
@export var max_skills_in_map: int = 50

@export var rect_limit_spawn: Rect2 

var points_instances = []
var obstacles_instances = []
var skills_instances = []

@onready var map: Node2D = $OxygenSources
@onready var minimap = $HUD/Minimappa
@onready var skills: Node2D = $Skills

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = player_scene.instantiate()
	player.ready.connect(func (): minimap.set_player(player))
	add_child(player)

func spawn_random_in_radius(scene: PackedScene, center: Vector2, radius: float) -> Node2D:
	var object: Node2D = scene.instantiate()

	var angle = randf() * TAU
	
	var x = cos(angle) * radius
	var y = sin(angle) * radius
	
	var generated_position = center + Vector2(x, y)
	while not rect_limit_spawn.has_point(generated_position):
		angle = randf() * TAU
	
		x = cos(angle) * radius
		y = sin(angle) * radius
	
		generated_position = center + Vector2(x, y)
	object.position = generated_position
	return object

func _on_spawn_point_cooldown_timeout() -> void:
	if points_instances.size() < max_points_in_map:
		var rand_range = randi() % max_spawn_distance + min_spawn_distance
		var point = spawn_random_in_radius(skill_point_scene, player.position, rand_range)
		map.add_child(point)
		points_instances.append(point)
		
func _on_spawn_skill_cooldown_timeout() -> void:
	if PointsManager.armor_enabled and skills_instances.size() < max_skills_in_map:
		var rand_range = randi() % max_spawn_distance + min_spawn_distance
		var skill = spawn_random_in_radius(skill_point_scene, player.position, rand_range)
		map.add_child(skill)
		skills_instances.append(skill)

func _on_spawn_obstacle_cooldown_timeout() -> void:
	var rand_range = float(randi() % max_spawn_distance + min_spawn_distance) / 2
	var obstacle: Obstacle = spawn_random_in_radius(obstacle_scene, player.position, rand_range)
	obstacle.target = player
	map.add_child(obstacle)
	obstacles_instances.append(obstacle)
