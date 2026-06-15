extends BaseAttribute
class_name HungerAttribute

@export var hunger_value: float = 0

func modify(affected: Node) -> void:
	var hunger_component: Hunger = find_component(affected, Hunger)
	hunger_component.modify_hunger(hunger_value)
