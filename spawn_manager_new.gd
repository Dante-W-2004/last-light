extends Node2D

# Enemy scenes
@export var stalker_scene: PackedScene
@export var sentry_scene: PackedScene

# Enemy limits
@export var max_enemies: int = 4

# TileMap reference
@export var tilemap: TileMap

# Spawn rules measured in tiles walked
@export var stalker_spawn_tiles: float = 20.0
@export var sentry_spawn_tiles: float = 50.0

# Spawn/despawn distance rules
@export var camera_safe_radius_tiles: float = 12.0
@export var spawn_radius_tiles: float = 25.0
@export var despawn_distance_tiles: float = 20.0
@export var max_spawn_attempts: int = 50

const WALKABLE_LAYER := 1
const WATER_LAYER := 2
const TREE_LAYER := 3

var player: Player = null
var last_player_position: Vector2
var stalker_walk_counter: float = 0.0
var sentry_walk_counter: float = 0.0
var spawned_enemies: Array[Dictionary] = []


func _ready():
	find_player()

	if player != null:
		last_player_position = player.global_position


# Tracks player movement, spawns enemies after enough tiles walked,
# and despawns enemies that are too far from their spawn area.
func _process(delta):
	if player == null:
		find_player()
		return

	track_player_tiles_walked()
	clean_enemy_list()
	despawn_far_enemies()

	if spawned_enemies.size() >= max_enemies:
		return

	if stalker_walk_counter >= stalker_spawn_tiles:
		stalker_walk_counter = 0.0
		spawn_enemy(stalker_scene)

	if sentry_walk_counter >= sentry_spawn_tiles:
		sentry_walk_counter = 0.0
		spawn_enemy(sentry_scene)


func find_player():
	var players = get_tree().get_nodes_in_group("player")

	if players.size() > 0:
		player = players[0]


# Converts player movement from pixels into tile-distance.
func track_player_tiles_walked():
	var tile_size = get_tile_size()
	var distance_pixels = player.global_position.distance_to(last_player_position)
	var distance_tiles = distance_pixels / tile_size

	stalker_walk_counter += distance_tiles
	sentry_walk_counter += distance_tiles

	last_player_position = player.global_position


# Spawns a chosen enemy scene at a randomized valid tile.
func spawn_enemy(enemy_scene: PackedScene):
	if enemy_scene == null:
		return

	var spawn_position = get_random_spawn_position()

	if spawn_position == null:
		return

	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_position

	get_tree().current_scene.add_child(enemy)

	spawned_enemies.append({
		"enemy": enemy,
		"spawn_position": spawn_position
	})


# Finds a random walkable position outside the camera-safe area.
func get_random_spawn_position():
	var walkable_cells = tilemap.get_used_cells(WALKABLE_LAYER)

	if walkable_cells.is_empty():
		return null

	var tile_size = get_tile_size()
	var camera_safe_radius = camera_safe_radius_tiles * tile_size
	var spawn_radius = spawn_radius_tiles * tile_size

	for i in range(max_spawn_attempts):
		var cell = walkable_cells.pick_random()

		if not is_valid_spawn_cell(cell):
			continue

		var world_position = tilemap.to_global(tilemap.map_to_local(cell))
		var distance = world_position.distance_to(player.global_position)

		if distance > camera_safe_radius and distance <= spawn_radius:
			return world_position

	return null


# Rejects blocked tiles.
func is_valid_spawn_cell(cell: Vector2i) -> bool:
	var has_water = tilemap.get_cell_source_id(WATER_LAYER, cell) != -1
	var has_tree = tilemap.get_cell_source_id(TREE_LAYER, cell) != -1

	return not has_water and not has_tree


# Deletes enemies when the player is too far from their original spawn area.
func despawn_far_enemies():
	var tile_size = get_tile_size()
	var despawn_distance = despawn_distance_tiles * tile_size

	for data in spawned_enemies:
		var enemy = data["enemy"]
		var spawn_position = data["spawn_position"]

		if is_instance_valid(enemy):
			var distance = player.global_position.distance_to(spawn_position)

			if distance >= despawn_distance:
				enemy.queue_free()


# Removes deleted enemies from the tracking list.
func clean_enemy_list():
	spawned_enemies = spawned_enemies.filter(
		func(data): return is_instance_valid(data["enemy"])
	)


func get_tile_size() -> float:
	return float(tilemap.tile_set.tile_size.x)
