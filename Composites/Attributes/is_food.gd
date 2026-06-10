extends BaseAttribute
class_name IsFood

@export var food_amount: float = 0
@export var heal_amount: float = 0

func is_consumed(_affected: Node) -> void:
	for child in _affected.get_children(true):
		if child is Hunger:
			child.modify_hunger(food_amount)
		elif child is Health:
			child.modify_health(heal_amount)
