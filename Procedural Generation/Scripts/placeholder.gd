extends Sprite2D

func _on_area_2d_body_entered(body: StaticBody2D) -> void:
	for Trees in get_tree().get_nodes_in_group("Trees"):
		Trees.queue_free()
		queue_free()
