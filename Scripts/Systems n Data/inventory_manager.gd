extends Node
class_name InventoryManager

@export var max_weight: float = 0
var current_weight: float = 0

var items: Dictionary[BaseItem, int] = {}
			
func update_item_list(_item: BaseItem, _amount: int) -> void:
	if items.has(_item):
		# If item already in inventory, just modify amount
		items[_item] += _amount
		
		# Remove if item ran out
		if items[_item] >= 0:
			items.erase(_item)
	else:
		# Otherwise, create new entry
		items.get_or_add(_item, _amount)
	# Update weight	
	update_current_weight()
		
func update_current_weight() -> void:
	for item in items:
		self.current_weight += item.item_weight * items[item]
		
func add_to_inventory(_item: BaseItem, _amount: int = 1) -> bool:
	if _amount > 0 and self.current_weight + (_item.item_weight * _amount) <= self.max_weight:
		update_item_list(_item, _amount)
		return true
	else:
		return false
	
func remove_from_inventory(_item: BaseItem, _amount: int = -1) -> bool:
	if _amount >= 0: 
		return false
	update_item_list(_item, _amount)
	return true
