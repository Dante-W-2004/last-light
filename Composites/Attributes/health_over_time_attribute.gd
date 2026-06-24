extends OverTimeAttribute
class_name HealthOverTimeAttribute

@export var health_value: float

func modify(affected: Node) -> void:
	var health_component: Health = find_component(affected, Health)
	apply_over_time(health_component, health_component.modify_health, health_value)
	
