extends Resource
class_name BaseItemData

@export var item_name: String = "Default Name"
@export_multiline var item_description: String = "A default item description of a respectable length."

@export var item_weight: float = 0
@export var item_value: float = 0
@export var item_rarity: Rarity.Rarity = Rarity.Rarity.COMMON
@export var item_category: ItemType.ItemType = ItemType.ItemType.MISC

var item_scene: PackedScene
