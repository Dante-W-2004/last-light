extends OverTimeAttribute
class_name HungerOverTimeAttribute

@export var hunger_value: float = 0

func modify(affected: Node) -> void:
	var hunger_component: Hunger = find_component(affected, Hunger)
	apply_over_time(hunger_component, hunger_component.modify_hunger, hunger_value)
