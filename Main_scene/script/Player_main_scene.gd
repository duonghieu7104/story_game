extends Control

@onready var ui_inventory = $main_scene/Inventory/ScrollContainer/VBoxContainer
var box_weapon = preload("res://Inventory/scene/weapon_box.tscn")

func _ready():
	PlayerData.load_data()
	
	for weapon in PlayerData.inventory.inventory_weapon:
		var instantiate = box_weapon.instantiate()
		ui_inventory.add_child(instantiate)
		var temp : String = ""
		for key in weapon.keys():
			temp += str(key) + ": " + str(weapon[key]) + "\n"
		instantiate.stats_view.text = temp
		print(temp)
		temp = ""


func _process(delta):
	pass


func _on_button_pressed():
	PlayerData.inventory.generate_item("Sword", {"damage": 10, "type": "Melee"})


func _on_button_2_pressed():
	PlayerData.save_data()
