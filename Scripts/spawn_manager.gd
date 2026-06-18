extends Node2D

const stalker: PackedScene = preload("res://Scenes/stalker.tscn")

@export var spawn_timer: float = 5.0
@onready var anchor: Node2D = $anchor

var can_spawn: bool = true

func _physics_process(delta: float) -> void:
	if can_spawn:
		spawn_wolf()

func spawn_wolf() -> void:
	can_spawn = false
	var wolf = stalker.instantiate()
	get_tree().current_scene.add_child(wolf)
	wolf.global_position = anchor.global_position
	print("Wolf spawned")
	await get_tree().create_timer(spawn_timer).timeout
	can_spawn = true
