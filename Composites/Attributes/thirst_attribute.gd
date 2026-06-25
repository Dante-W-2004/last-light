extends BaseAttribute
class_name ThirstAttribute

@export var thirst_value: float = 0

func modify(affected: Node) -> void:
	var thirst_component: Thirst = find_component(affected, Thirst)
	if thirst_component:
		thirst_component.modify_thirst(thirst_value)
