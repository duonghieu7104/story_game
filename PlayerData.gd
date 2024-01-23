extends Node

#file path
var save_file_path = "user://save_"
var save_file_name_inventory = "inventory.tres"
var save_file_name_stats = "stats.tres"

var inventory = Inventory_weapon.new()
var stats = Stats.new()

func generate_item(type : String, stats : Dictionary):
	inventory.generate_item(type, stats)

func save_data():
	ResourceSaver.save(inventory, save_file_path + save_file_name_inventory)

func load_data():
	if ResourceLoader.exists(save_file_path + save_file_name_inventory):
		print("Tim thay file")
		inventory = ResourceLoader.load(save_file_path + save_file_name_inventory).duplicate(true)
	else:
		print("Khong tim thay file")

func load_stats():
	pass
	stats.hp += stats.health * 10

