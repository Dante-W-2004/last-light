extends Control
class_name InventoryTreeManager

@export var inventory_manager: InventoryManager
@export var item_card: ItemCard

@export var inventory_tree: Tree
var inventory_catagories: Array[TreeItem] = []
var inventory_weight: TreeItem

func _ready() -> void:
	item_card.set_card_display(false)
	ready_tree()
	inventory_manager.inventory_changed.connect(update_tree)
	
	inventory_tree.item_selected.connect(update_item_card)
	inventory_tree.nothing_selected.connect(clear_item_card)

func ready_tree() -> void:
	var title: TreeItem = inventory_tree.create_item() 
	title.set_text(0, "Inventory")
	
	var weight_display: TreeItem = inventory_tree.create_item(title) 
	weight_display.set_text(0, ("Weight: " + str(inventory_manager.current_weight) + "/" + str(inventory_manager.max_weight)))
	weight_display.set_custom_font_size(0, 40)
	weight_display.set_selectable(0, false)
	inventory_weight = weight_display
	
	for item_type: String in ItemType.ItemType:
		var new_category: TreeItem = inventory_tree.create_item(title) 
		new_category.set_text(0, item_type)
		new_category.set_custom_font_size(0, 40)
		new_category.set_selectable(0, false)
		inventory_catagories.append(new_category)

# This is bad and should work with deltas instead
# But I'm lazy and this works fine
func update_tree() -> void:
	clear_item_card()
	
	inventory_weight.set_text(0, ("Weight: " + str(inventory_manager.current_weight) + "/" + str(inventory_manager.max_weight)))
	
	for category: TreeItem in inventory_catagories:
		for tree_item: TreeItem in category.get_children():
			tree_item.free()
	
	for item: BaseItemData in inventory_manager.items:
		var category: ItemType.ItemType = item.item_category
		var tree_item: TreeItem = inventory_tree.create_item(inventory_catagories[category as int])
		tree_item.set_custom_font_size(0, 25)
		tree_item.set_text(0, item.item_name)
		tree_item.set_custom_color(0, Color.DARK_GRAY)
		tree_item.set_metadata(0, item)
		
	for category in inventory_catagories:
		category.set_collapsed_recursive(false) 
		
# Maybe not exactly correct but fucking whatever lmfao
func update_item_card() -> void:
	var item_data: BaseItemData = self.inventory_tree.get_selected().get_metadata(0)
	item_card.update_item_card(item_data)
	item_card.set_card_display(true, item_data.allow_use)

func clear_item_card() -> void:
	item_card.set_card_display(false)
	inventory_tree.deselect_all()


func _on_use_button_button_up() -> void:
	var item_data: BaseItemData = self.inventory_tree.get_selected().get_metadata(0)
	# Bad practice, since not all items should automatically affect the player
	inventory_manager.remove_from_inventory(item_data, true, get_tree().get_first_node_in_group("player"))
	
func _on_drop_button_button_up() -> void:
	var item_data: BaseItemData = self.inventory_tree.get_selected().get_metadata(0)
	inventory_manager.remove_from_inventory(item_data)
