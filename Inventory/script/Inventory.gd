extends Resource

class_name Inventory

@export var inventory = []

#them iteam vao list
func add_item_to_Inventory(item):
	inventory.append(item)

#tao iteam
func generate_item(type : String, key : String, value : int):
	var new_item = Item.new(type, key, value)
	add_item_to_Inventory(new_item)
