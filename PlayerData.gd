extends Node

#file path
var save_file_path = "user://save_"
var save_file_name_inventory = "inventory.tres"
var save_file_name_stats = "stats.tres"

var inventory = Inventory_weapon.new()
var stats = Stats.new()

func generate_item():
	inventory.generate_item("dual_sword", "atk", 5, "heavy", 10)

func save_data():
	ResourceSaver.save(inventory, save_file_path + save_file_name_inventory)

func load_data():
	inventory = ResourceLoader.load(save_file_path + save_file_name_inventory).duplicate(true)

func reload_stats():
	pass
	stats.hp += stats.health * 10

