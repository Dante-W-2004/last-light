extends Node2D

@export var stalker_scene: PackedScene
@export var sentry_scene: PackedScene
@export var tilemap: TileMap

const WALKABLE_LAYER := 1
const WATER_LAYER := 2
const TREE_LAYER := 3

func _ready():
	spawn_enemy(stalker_scene)

func spawn_enemy(enemy_scene: PackedScene):
	var spawn_position = get_random_walkable_position()
	if spawn_position == null:
		return

	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_position
	get_tree().current_scene.add_child(enemy)

func get_random_walkable_position():
	var walkable_cells = tilemap.get_used_cells(WALKABLE_LAYER)
	var valid_cells := []

	for cell in walkable_cells:
		var has_water = tilemap.get_cell_source_id(WATER_LAYER, cell) != -1
		var has_tree = tilemap.get_cell_source_id(TREE_LAYER, cell) != -1

		if not has_water and not has_tree:
			valid_cells.append(cell)

	if valid_cells.is_empty():
		return null

	var random_cell = valid_cells.pick_random()
	return tilemap.to_global(tilemap.map_to_local(random_cell))
