extends BaseAttribute
class_name HealthAttribute

@export var health_value: float = 0

func modify(affected: Node) -> void:
	var health_component: Health = find_component(affected, Health)
	if health_component:
		health_component.modify_health(health_value)
