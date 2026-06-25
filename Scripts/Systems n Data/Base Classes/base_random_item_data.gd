@tool
extends BaseItemData
class_name BaseRandomItemData

@export var min_item_weight: float = 0
@export var max_item_weight: float = 0

@export var min_item_value: float = 0
@export var max_item_value: float = 0

@export var possible_rarities: Array[Rarity.Rarity]

@export var randomised: bool = false

func _validate_property(property: Dictionary) -> void:
	self.resource_local_to_scene = true
	self.exluded_variables.append_array(["item_weight", "item_value", "item_rarity", "randomised"])
	if self.exluded_variables.has(property.name):
		property.usage = PROPERTY_USAGE_NO_EDITOR

func randomise_values() -> void:
	var random: RandomNumberGenerator = RandomNumberGenerator.new()
	
	self.item_weight = snappedf(random.randf_range(min_item_weight, max_item_weight), 0.1)
	self.item_value = snappedf(random.randf_range(min_item_value, max_item_value), 0.1)
	self.item_rarity = self.possible_rarities.pick_random()	
	
	self.randomised = true
