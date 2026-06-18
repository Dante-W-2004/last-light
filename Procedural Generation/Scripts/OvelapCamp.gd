extends Area2D

func _ready() -> void:
	var overlap = get_overlapping_bodies()
	for body in overlap:
		if body.is_in_group("Trees"):
			get_tree().get_nodes_in_group("Trees")
			body.queue_free()
			
