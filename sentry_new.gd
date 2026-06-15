extends Node2D

@export var enemy_scene: PackedScene
@export var tilemap: TileMap
@export var map_size: int = 200
@export var spawn_interval: float = 3.0

@onready var spawn_timer: Timer = $SpawnTimer

func _ready():
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(spawn_enemy)
	spawn_timer.start()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()

	var random_tile := Vector2i(
		randi_range(0, map_size - 1),
		randi_range(0, map_size - 1)
	)

	enemy.global_position = tilemap.map_to_local(random_tile)

	get_tree().current_scene.add_child(enemy)
