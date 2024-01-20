class_name Inventory

extends Resource

@export var items = []

#them iteam vao list
func add_item(item):
	items.append(item)

#tao iteam
func generate_iteam():
	var item = Item.new()
	var randomnumber : RandomNumberGenerator
	var types = ["sword", "helmet", "amor", "leg amor"]
