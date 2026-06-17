extends Node
class_name InventoryManager

@export var inventory_tree: Tree
var inventory_catagories: Array[TreeItem] = []

@export var max_weight: float = 0
var current_weight: float = 0

@export var items: Array[BaseItemData] = []

func _ready() -> void:
	ready_tree()
	populate_tree()
		
func add_to_inventory(_item_data: BaseItemData) -> bool:
	if self.current_weight + _item_data.item_weight <= self.max_weight:
		items.append(_item_data)
		current_weight += _item_data.item_weight
		return true
	return false
	
func remove_from_inventory(_item_data: BaseItemData) -> bool:
	if items.has(_item_data):
		items.erase(_item_data)
		current_weight -= _item_data.item_weight
		return true
	return false

func ready_tree() -> void:
	var title: TreeItem = inventory_tree.create_item() 
	title.set_text(0, "Inventory")
	
	for item_type: String in ItemType.ItemType:
		var new_category: TreeItem = inventory_tree.create_item(title) 
		new_category.set_text(0, item_type)
		new_category.set_custom_font_size(0, 30)
		new_category.set_selectable(0, false)
		inventory_catagories.append(new_category)

# This is bad and should work via signals with single items
# Also should be moved into separate node probably
func populate_tree() -> void:
	for item: BaseItemData in items:
		var category: ItemType.ItemType = item.item_category
		var tree_item: TreeItem = inventory_tree.create_item(inventory_catagories[category as int])
		tree_item.set_text(0, item.item_name)
		tree_item.set_custom_color(0, Color.DARK_GRAY)
		
	for category in inventory_catagories:
		category.set_collapsed_recursive(false) 
		
