extends Node2D

@onready var area_2d: Area2D = %Area2D

@export var stalker: Array[PackedScene] = []
@onready var collision_spawn_area: CollisionShape2D = %CollisionSpawnArea
@onready var waitspawn: Timer = %WAITSPAWN

func _on_area_2d_body_entered(body: Node2D) -> void:
	if waitspawn.is_stopped() and body.is_in_group("player"):
		var spawnstalker: Node2D = stalker.pick_random().instantiate()
		self.add_child(spawnstalker)
		waitspawn.start()
