extends Control

var inventory = Inventory.new()
var save_file_path = "user://save_"
var save_file_name = "inventory.tres"

func _ready():
	pass

func _process(delta):
	pass


func _on_button_pressed():
	inventory.generate_item("kiem", "atk", 5)


func _on_save_pressed():
	ResourceSaver.save(inventory, save_file_path + save_file_name)


func _on_load_pressed():
	inventory = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
