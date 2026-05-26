@tool
extends Resource
class_name PhysicsShape

enum ShapeType { CIRCLE, RECTANGLE, CUSTOM }

var radius: float = 1.0
var dimensions: Vector2 = Vector2(1, 1)
var custom_inertia: float = 1.0

var shape_type: ShapeType = ShapeType.CIRCLE:
	set(value):
		shape_type = value
		notify_property_list_changed()
		
func _get_property_list() -> Array:
	var properties: Array = []

	properties.append({
		"name": "shape_type",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "CIRCLE,RECTANGLE,CUSTOM",
		"usage": PROPERTY_USAGE_DEFAULT
	})

	match shape_type:
		ShapeType.CIRCLE:
			properties.append({
				"name": "radius",
				"type": TYPE_FLOAT,
				"usage": PROPERTY_USAGE_DEFAULT
			})

		ShapeType.RECTANGLE:
			properties.append({
				"name": "dimensions",
				"type": TYPE_VECTOR2,
				"usage": PROPERTY_USAGE_DEFAULT
			})

		ShapeType.CUSTOM:
			properties.append({
				"name": "custom_inertia",
				"type": TYPE_FLOAT,
				"usage": PROPERTY_USAGE_DEFAULT
			})

	return properties
	
func _set(property, value):
	match property:
		"shape_type":
			shape_type = value
			notify_property_list_changed()
			return true
		"radius":
			radius = value
			return true
		"dimensions":
			dimensions = value
			return true
		"custom_inertia":
			custom_inertia = value
			return true

	return false

func _get(property):
	match property:
		"shape_type": return shape_type
		"radius": return radius
		"dimensions": return dimensions
		"custom_inertia": return custom_inertia

	return null
			
func calculate_inertia(mass: float = 1) -> float:
	match shape_type:
		ShapeType.CIRCLE:
			return 0.5 * mass * radius * radius
		ShapeType.RECTANGLE:
			return (1.0/12.0) * mass * (dimensions.x * dimensions.x + dimensions.y * dimensions.y)
		ShapeType.CUSTOM:
			return custom_inertia * mass
		_:
			return -1
