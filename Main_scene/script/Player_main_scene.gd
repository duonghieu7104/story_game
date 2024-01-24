extends Control

@onready var ui_inventory = $main_scene/Inventory/ScrollContainer/VBoxContainer
@onready var ui_equipped = $main_scene/Inventory/Equipped
var box_weapon = preload("res://Inventory/scene/weapon_box.tscn")


func _ready():
	PlayerData.load_data()
	load_ui_inventory()
	upload_texture_equipped()

func _process(delta):
	pass


func _on_button_pressed():
	PlayerData.inventory.generate_item("Sword", "res://icon.svg", {"damage": 10, "type": "Melee"})


func _on_button_2_pressed():
	PlayerData.save_data()

func load_ui_inventory():
	for weapon in PlayerData.inventory.inventory_weapon:
		var instantiate = box_weapon.instantiate()
		ui_inventory.add_child(instantiate)
		var temp : String = ""
		for key in weapon.keys():
			if key == "texture_path":
				continue
			temp += str(key) + ": " + str(weapon[key]) + "\n"
		instantiate.stats_view.text = temp
		var path = weapon["texture_path"]
		instantiate.texture_view.texture = load(path)
		print(temp)

func remove_all_children(parent):
	var children = parent.get_children()
	for child in children:
		parent.remove_child(child)

func upload_texture_equipped():
	for key in PlayerData.inventory.dict_select_equip.keys():
		var i : int = -1
		i += 1
		var index = PlayerData.inventory.dict_select_equip[key]
		if index == -1:
			continue
		var weapon = PlayerData.inventory.inventory_weapon[index]
		var path = weapon["texture_path"]
		ui_equipped.get_child(i).texture = load(path)
