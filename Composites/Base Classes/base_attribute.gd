@abstract
extends Node
class_name BaseAttribute

## Finds the component of a specific class in a given node.
## Returns node if found, otherwise returns null.
func find_component(affected: Node, component_type: GDScript) -> Node:
	for node in affected.get_children():
		if node.get_script() == component_type:
			return node
	return
	
## An abstract function to unify attribute calls.
## Override with custom implementation.
## Ensure the node has the component, or handle null references.	
func modify(affected: Node) -> void:
	pass
