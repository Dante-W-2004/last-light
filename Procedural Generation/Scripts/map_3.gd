extends Node2D

@onready var dead_tree: StaticBody2D = $DeadTrees/DeadTree

@export var noise_height_text : NoiseTexture2D
@export var noise_treesnstuff_text : NoiseTexture2D
@export var gradient : GradientTexture2D
var gradientImage : Image
var falloffgrad : Gradient

var RandomWorld = RandomNumberGenerator
var noise : Noise
var treesnstuff : Noise

var width : int = 200
var height : int = 200

@onready var tile_map: TileMap = $TileMap

var noise_val_arr = []

var source_id = 1
var source_id_scenes = 0

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
	gradientImage = gradient.get_image()
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

			var mapSize = Vector2(x, y)
			var mapCenter = Vector2(mapSize) / 2
			var distFromCent = mapSize - mapCenter
			var maxDist = mapCenter.length()
			var noise_value_2 = (noise_value + 1.0) / 2
			var normDist = clamp(distFromCent.length() / maxDist, 0.0, 1.0)

			var falloff = gradient.gradient.sample(normDist).r

			var final_value: float = noise_value_2 * falloff

			if final_value >= 0.0:
				if final_value <= 0.2:
					water_tiles_arr.append(Vector2i(x,y))
				
				elif final_value > 0.2 && final_value < 0.3:
					sand_tiles_arr.append(Vector2i(x,y))

				elif final_value >= 0.3 && final_value < 0.7:
					grass_tiles_arr.append(Vector2i(x,y))
					
				elif final_value >= 0.7:
					tall_tiles_arr.append(Vector2i(x,y))
				else:
					print("Failed placement: ", final_value)
			else:
				print("Oh no (No swearing please): ", noise_value)
					
				
					
				# Separate logic, does not interact with actual tilemap	
				if final_value > 0.2 and final_value < 0.5 and treesnstuff_value > 0.5 and treesnstuff_value < 0.7:
					tile_map.set_cell(trees_n_stuff_layer, Vector2(x,y), source_id, treesnstuff_atlas)
					for i in range(200):
						var TreesPlease: Array[Vector2i] = tile_map.get_used_cells(trees_n_stuff_layer)
						var RandomCoord: Vector2i = TreesPlease.pick_random()
						var CoordPosition: Vector2 = tile_map.map_to_local(RandomCoord)
						var TreeArray = [$NotDeadTrees/NotDeadTree, $NotDeadTrees/NotDeadTree2, $NotDeadTrees/NotDeadTree3, $NotDeadTrees/NotDeadTree4, $NotDeadTrees/NotDeadTree5, $NotDeadTrees/NotDeadTree6, $NotDeadTrees/NotDeadTree7, $NotDeadTrees/NotDeadTree8, $NotDeadTrees/NotDeadTree9, $NotDeadTrees/NotDeadTree10, $NotDeadTrees/NotDeadTree11, $NotDeadTrees/NotDeadTree12, $NotDeadTrees/NotDeadTree13, $NotDeadTrees/NotDeadTree14, $NotDeadTrees/NotDeadTree15, $NotDeadTrees/NotDeadTree16, $NotDeadTrees/NotDeadTree17, $NotDeadTrees/NotDeadTree18, $NotDeadTrees/NotDeadTree19, $NotDeadTrees/NotDeadTree20, $NotDeadTrees/NotDeadTree21, $NotDeadTrees/NotDeadTree22, $NotDeadTrees/NotDeadTree23, $NotDeadTrees/NotDeadTree24, $NotDeadTrees/NotDeadTree25, $NotDeadTrees/NotDeadTree26, $NotDeadTrees/NotDeadTree27, $NotDeadTrees/NotDeadTree28, $NotDeadTrees/NotDeadTree29, $NotDeadTrees/NotDeadTree30, $NotDeadTrees/NotDeadTree31, $NotDeadTrees/NotDeadTree32, $NotDeadTrees/NotDeadTree33, $NotDeadTrees/NotDeadTree34, $NotDeadTrees/NotDeadTree35, $NotDeadTrees/NotDeadTree36, $NotDeadTrees/NotDeadTree37, $NotDeadTrees/NotDeadTree38, $NotDeadTrees/NotDeadTree39, $NotDeadTrees/NotDeadTree40, $NotDeadTrees/NotDeadTree41, $NotDeadTrees/NotDeadTree42, $NotDeadTrees/NotDeadTree43, $NotDeadTrees/NotDeadTree44, $NotDeadTrees/NotDeadTree45, $NotDeadTrees/NotDeadTree46, $NotDeadTrees/NotDeadTree47, $NotDeadTrees/NotDeadTree48, $NotDeadTrees/NotDeadTree49, $NotDeadTrees/NotDeadTree50, $NotDeadTrees/NotDeadTree51, $NotDeadTrees/NotDeadTree52, $NotDeadTrees/NotDeadTree53, $NotDeadTrees/NotDeadTree54, $NotDeadTrees/NotDeadTree55, $NotDeadTrees/NotDeadTree56, $NotDeadTrees/NotDeadTree57, $NotDeadTrees/NotDeadTree58, $NotDeadTrees/NotDeadTree59, $NotDeadTrees/NotDeadTree60, $NotDeadTrees/NotDeadTree61, $NotDeadTrees/NotDeadTreea, $NotDeadTrees/NotDeadTreeb, $NotDeadTrees/NotDeadTreee, $NotDeadTrees/NotDeadTreef, $NotDeadTrees/NotDeadTreeg, $NotDeadTrees/NotDeadTreeh, $NotDeadTrees/NotDeadTreei, $NotDeadTrees/NotDeadTreej, $NotDeadTrees/NotDeadTreew, $NotDeadTrees/NotDeadTree71, $NotDeadTrees/NotDeadTree72, $NotDeadTrees/NotDeadTree73, $NotDeadTrees/NotDeadTree74, $NotDeadTrees/NotDeadTree75, $NotDeadTrees/NotDeadTree76, $NotDeadTrees/NotDeadTree77, $NotDeadTrees/NotDeadTree78, $NotDeadTrees/NotDeadTree79, $NotDeadTrees/NotDeadTree80, $NotDeadTrees/NotDeadTree81, $NotDeadTrees/NotDeadTree82, $NotDeadTrees/NotDeadTree83, $NotDeadTrees/NotDeadTree84, $NotDeadTrees/NotDeadTree85, $NotDeadTrees/NotDeadTree86, $NotDeadTrees/NotDeadTree87, $NotDeadTrees/NotDeadTree88, $NotDeadTrees/NotDeadTree89, $NotDeadTrees/NotDeadTree90, $NotDeadTrees/NotDeadTree91, $NotDeadTrees/NotDeadTree92, $NotDeadTrees/NotDeadTree93, $NotDeadTrees/NotDeadTree94, $NotDeadTrees/NotDeadTree95, $NotDeadTrees/NotDeadTree96, $NotDeadTrees/NotDeadTree97, $NotDeadTrees/NotDeadTree98, $NotDeadTrees/NotDeadTree99, $DeadTrees/DeadTree, $DeadTrees/DeadTree101, $DeadTrees/DeadTree102, $DeadTrees/DeadTree103, $DeadTrees/DeadTree104, $DeadTrees/DeadTree105, $DeadTrees/DeadTree106, $DeadTrees/DeadTree107, $DeadTrees/DeadTree108, $DeadTrees/DeadTree109, $DeadTrees/DeadTree110, $DeadTrees/DeadTree111, $DeadTrees/DeadTree112, $DeadTrees/DeadTree113, $DeadTrees/DeadTree114, $DeadTrees/DeadTree115, $DeadTrees/DeadTree116, $DeadTrees/DeadTree117, $DeadTrees/DeadTree118, $DeadTrees/DeadTree119, $DeadTrees/DeadTree120, $DeadTrees/DeadTree121, $DeadTrees/DeadTree122, $DeadTrees/DeadTree123, $DeadTrees/DeadTree124, $DeadTrees/DeadTree125, $DeadTrees/DeadTree126, $DeadTrees/DeadTree127, $DeadTrees/DeadTree128, $DeadTrees/DeadTree129, $DeadTrees/DeadTree130, $DeadTrees/DeadTree131, $DeadTrees/DeadTree132, $DeadTrees/DeadTree133, $DeadTrees/DeadTree134, $DeadTrees/DeadTree135, $DeadTrees/DeadTree136, $DeadTrees/DeadTree137, $DeadTrees/DeadTree138, $DeadTrees/DeadTree139, $DeadTrees/DeadTree140, $DeadTrees/DeadTree141, $DeadTrees/DeadTree142, $DeadTrees/DeadTree143, $DeadTrees/DeadTree144, $DeadTrees/DeadTree145, $DeadTrees/DeadTree146, $DeadTrees/DeadTree147, $DeadTrees/DeadTree148, $DeadTrees/DeadTree149, $DeadTrees/DeadTreef, $DeadTrees/DeadTreee, $DeadTrees/DeadTreew, $DeadTrees/DeadTreec, $DeadTrees/DeadTreeb, $DeadTrees/DeadTreea, $DeadTrees/DeadTree70, $DeadTrees/DeadTree71, $DeadTrees/DeadTree72, $DeadTrees/DeadTree73, $DeadTrees/DeadTree74, $DeadTrees/DeadTree75, $DeadTrees/DeadTree76, $DeadTrees/DeadTree77, $DeadTrees/DeadTree78, $DeadTrees/DeadTree79, $DeadTrees/DeadTree80, $DeadTrees/DeadTree81, $DeadTrees/DeadTree82, $DeadTrees/DeadTree83, $DeadTrees/DeadTree84, $DeadTrees/DeadTree85, $DeadTrees/DeadTree86, $DeadTrees/DeadTree87, $DeadTrees/DeadTree88, $DeadTrees/DeadTree89, $DeadTrees/DeadTree90, $DeadTrees/DeadTree91, $DeadTrees/DeadTree92, $DeadTrees/DeadTree93, $DeadTrees/DeadTree94, $DeadTrees/DeadTree95, $DeadTrees/DeadTree96, $DeadTrees/DeadTree97, $DeadTrees/DeadTree98, $DeadTrees/DeadTree99, $DeadTrees/DeadTree100, $DeadTrees/DeadTree2, $DeadTrees/DeadTree3, $DeadTrees/DeadTree4, $DeadTrees/DeadTree5, $DeadTrees/DeadTree6, $DeadTrees/DeadTree7, $DeadTrees/DeadTree8, $DeadTrees/DeadTree9, $DeadTrees/DeadTree10, $DeadTrees/DeadTree11, $DeadTrees/DeadTree12, $DeadTrees/DeadTree13, $DeadTrees/DeadTree14, $DeadTrees/DeadTree15, $DeadTrees/DeadTree16, $DeadTrees/DeadTree17, $DeadTrees/DeadTree18, $DeadTrees/DeadTree19, $DeadTrees/DeadTree20, $DeadTrees/DeadTree21, $DeadTrees/DeadTree22, $DeadTrees/DeadTree23, $DeadTrees/DeadTree24, $DeadTrees/DeadTree25, $DeadTrees/DeadTree26, $DeadTrees/DeadTree27, $DeadTrees/DeadTree28, $DeadTrees/DeadTree29, $DeadTrees/DeadTree30, $DeadTrees/DeadTree31, $DeadTrees/DeadTree32, $DeadTrees/DeadTree33, $DeadTrees/DeadTree34, $DeadTrees/DeadTree35, $DeadTrees/DeadTree36, $DeadTrees/DeadTree37, $DeadTrees/DeadTree38, $DeadTrees/DeadTree39, $DeadTrees/DeadTree40, $DeadTrees/DeadTree41, $DeadTrees/DeadTree42, $DeadTrees/DeadTree43, $DeadTrees/DeadTree44, $DeadTrees/DeadTree45, $DeadTrees/DeadTree46, $DeadTrees/DeadTree47, $DeadTrees/DeadTree48, $DeadTrees/DeadTree49, $DeadTrees/DeadTree50, $DeadTrees/DeadTree51, $DeadTrees/DeadTree52, $DeadTrees/DeadTree53, $DeadTrees/DeadTree54, $DeadTrees/DeadTree55, $DeadTrees/DeadTree56, $DeadTrees/DeadTree57, $DeadTrees/DeadTree58, $DeadTrees/DeadTreey, $DeadTrees/DeadTreej, $DeadTrees/DeadTreei, $DeadTrees/DeadTreeh, $DeadTrees/DeadTreeg]
						var tree_scenes: Array[PackedScene] = [] # Put scene references here, or rather in an exported top-level array
						var RandomTree = TreeArray.pick_random()
						RandomTree.global_position = CoordPosition
						TreesPlease.erase(RandomCoord)
						TreeArray.erase(RandomTree)
			
	
	tile_map.set_cells_terrain_connect(grass_layer, grass_tiles_arr, 0, terrain_grass_int)
	tile_map.set_cells_terrain_connect(tall_layer, tall_tiles_arr, 0, terrain_tall_int)
	tile_map.set_cells_terrain_connect(water_layer, water_tiles_arr, 0, terrain_water_int)
	tile_map.set_cells_terrain_connect(sand_layer, sand_tiles_arr, 0, terrain_sand_int)
		
