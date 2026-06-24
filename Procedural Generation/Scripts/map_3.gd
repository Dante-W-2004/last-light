extends Node2D

@export var AllTreesIThink : Array[PackedScene] = []
@onready var trees: Node2D = %TREES

@export var noise_height_text : NoiseTexture2D
@export var noise_treesnstuff_text : NoiseTexture2D
@export var gradient : GradientTexture2D

var RandomWorld = RandomNumberGenerator
var noise : Noise
var treesnstuff : Noise

var width : int = 200
var height : int = 200

@onready var tile_map: TileMap = $TileMap

var noise_val_arr = []

var source_id = 1

var water_layer = 0
var grass_layer = 1
var sand_layer = 2
var tall_layer = 3
var trees_n_stuff_layer = 4

var sand_atlas = Vector2i(3,3)
var water_atlas = Vector2i(6,2)
var grass_atlas = Vector2i(1,0)
var tall_atlas = Vector2i(1, 2)
var treesnstuff_atlas = Vector2i(3,5)

var water_tiles_arr = []
var terrain_water_int = 0

var sand_tiles_arr = []
var terrain_sand_int = 2

var grass_tiles_arr = []
var terrain_grass_int = 1

var tall_tiles_arr = []
var terrain_tall_int = 3

var treesnstuff_tiles_arr = []
var terrain_treesnstuff_int = 4

func _ready():
	RandomWorld = RandomNumberGenerator.new
	var WorldNumber = randi_range(-1000000, 1000000)
	
	randomize()
	noise = noise_height_text.noise
	treesnstuff = noise_treesnstuff_text.noise
	noise.seed = WorldNumber
	treesnstuff.seed = WorldNumber
	generate_world()
	

func generate_world():

	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_value :float = noise.get_noise_2d(x, y)
			var treesnstuff_value :float = treesnstuff.get_noise_2d(x, y)
			var noise_value_2 = (noise_value + 1.0) / 2

			if noise_value_2 >= 0.0:
				if noise_value_2 <= 0.25:
					water_tiles_arr.append(Vector2i(x,y))
				
				elif noise_value_2 > 0.25 && noise_value_2 < 0.3:
					sand_tiles_arr.append(Vector2i(x,y))

				elif noise_value_2 >= 0.3 && noise_value_2 < 0.7:
					grass_tiles_arr.append(Vector2i(x,y))
					
				elif noise_value_2 >= 0.7:
					tall_tiles_arr.append(Vector2i(x,y))
					
				if noise_value_2 > 0.3 and noise_value_2 < 0.7 and treesnstuff_value > 0.5 and treesnstuff_value < 0.85:
					tile_map.set_cell(trees_n_stuff_layer, Vector2(x,y), source_id, treesnstuff_atlas)
					for i in range(2):
						var TreesPlease: Array[Vector2i] = tile_map.get_used_cells(trees_n_stuff_layer)
						var RandomCoord: Vector2i = TreesPlease.pick_random()
						var CoordPosition: Vector2 = tile_map.map_to_local(RandomCoord)
						var AddTrees: Node2D = AllTreesIThink.pick_random().instantiate()
						AddTrees.global_position = CoordPosition
						TreesPlease.erase(RandomCoord)
						trees.add_child(AddTrees)
					for i in range(15):
						var TreesPlease: Array[Vector2i] = tile_map.get_used_cells(trees_n_stuff_layer)
						var RandomCoord: Vector2i = TreesPlease.pick_random()
						var CoordPosition: Vector2 = tile_map.map_to_local(RandomCoord)
						var placeholderCampfire = [$Campfires/Campfire, $Campfires/Campfire2, $Campfires/Campfire3, $Campfires/Campfire4, $Campfires/Campfire5, $Campfires/Campfire6, $Campfires/Campfire7, $Campfires/Campfire8, $Campfires/Campfire9, $Campfires/Campfire10, $Campfires/Campfire11, $Campfires/Campfire12, $Campfires/Campfire13, $Campfires/Campfire14, $Campfires/Campfire15]
						var AddCampfire: Node2D = placeholderCampfire.pick_random()
						AddCampfire.global_position = CoordPosition
						TreesPlease.erase(RandomCoord)
						placeholderCampfire.erase(AddCampfire)
						
	tile_map.set_cells_terrain_connect(grass_layer, grass_tiles_arr, 0, terrain_grass_int, false)
	tile_map.set_cells_terrain_connect(tall_layer, tall_tiles_arr, 0, terrain_tall_int, false)
	tile_map.set_cells_terrain_connect(water_layer, water_tiles_arr, 0, terrain_water_int, false)
	tile_map.set_cells_terrain_connect(sand_layer, sand_tiles_arr, 0, terrain_sand_int, false)
		
