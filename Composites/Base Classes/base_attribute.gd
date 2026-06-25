@abstract
extends Node
class_name BaseAttribute

func _ready() -> void:
	add_to_group("Attribute")

func find_component(affected: Node, component_type: GDScript) -> Node:
	for node in affected.get_children():
		if node.get_script() == component_type:
			return node
	return

func modify(affected: Node) -> void:
	pass
