@abstract
extends Node
class_name BaseAttribute

@export var effects: Dictionary[String, BaseEffect] = {}

func _ready() -> void:
	add_to_group("Attribute")
