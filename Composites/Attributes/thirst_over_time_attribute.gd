extends OverTimeAttribute
class_name ThirstOverTimeAttribute

@export var thirst_value: float = 0

func modify(affected: Node) -> void:
	var thirst_component: Hunger = find_component(affected, Thirst)
	apply_over_time(thirst_component, thirst_component.modify_thirst, thirst_value)
