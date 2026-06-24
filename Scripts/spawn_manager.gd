extends Node2D

@onready var spawn_manager: Node2D = %spawn_manager

const stalker: PackedScene = preload("res://Scenes/stalker.tscn")
const sentry: PackedScene = preload("res://Scenes/sentry.tscn")

#@onready var anchor: Node2D = $anchor

var scarecrow = sentry.instantiate()
var wolf = stalker.instantiate()
var can_spawn: bool = true
#var maxEnemies = 6

func _ready() -> void:
	if can_spawn:
		spawn_wolf()
		print("Wolf spawned")
		spawn_sentry()
		print("Sentry spawned")
		can_spawn = false

func spawn_wolf() -> void:
	spawn_manager.add_child(wolf)
	print("Spawned wolf")
	
func spawn_sentry() -> void:
	spawn_manager.add_child(scarecrow)
	print("Spawned sentry")
	
