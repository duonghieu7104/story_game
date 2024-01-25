extends Control

@onready var ui_inventory = $Tab_Menu/Inventory/Weapon_inventory/Weapon/VBoxContainer
@onready var ui_equipped = $Tab_Menu/Inventory/Equipped/Player_Eqiupped/Texture_equipped
var box_weapon = preload("res://Inventory/scene/weapon_box.tscn")
var id : int

func _ready():
	PlayerData.load_data()
	load_ui_inventory()
	upload_texture_equipped()
	if ResourceLoader.exists("user://save_inventory.tres"):
		PlayerData.load_stats_from_equip()

func _process(delta):
	pass

func load_ui_inventory():
	var i : int = -1
	for weapon in PlayerData.inventory.inventory_weapon:
		i += 1
		var instantiate = box_weapon.instantiate()
		ui_inventory.add_child(instantiate)
		instantiate.id = i
		ui_inventory.get_child(i).connect("equip", equip_weapon_sword)
		var temp : String = ""
		for key in weapon.keys():
			if key == "texture_path" || key == "type":
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
	var i : int = -1
	for key in PlayerData.inventory.dict_select_equip.keys():
		i += 1
		var index = PlayerData.inventory.dict_select_equip[key]
		if index == -1:
			continue
			#ui_equipped.get_child(i).texture = load(path_slot_null)
		var weapon = PlayerData.inventory.inventory_weapon[index]
		var path = weapon["texture_path"]
		ui_equipped.get_child(i).texture = load(path)

func _on_button_pressed():
	PlayerData.inventory.generate_item("oh_sword", "res://icon.svg", {"atk" : 5})
	remove_all_children(ui_inventory)
	load_ui_inventory()

func _on_button_2_pressed():
	PlayerData.save_data()

func equip_weapon_sword(index_ivt):
	id = index_ivt
	var temp = PlayerData.inventory.inventory_weapon[index_ivt]
	if temp["type"] in ["oh_sword", "sword"]:
		$Stop_touch.visible = true
		$Popup_Notif.visible = true

func _on_slot_1_pressed():
	equip_sword("slot1")

func _on_slot_2_pressed():
	equip_sword("slot2")

func equip_sword(text : String):
	if PlayerData.inventory.dict_select_equip[text] == -1:
		PlayerData.inventory.dict_select_equip[text] = id
		upload_texture_equipped()
		PlayerData.load_stats_from_equip()
	else:
		PlayerData.inventory.dict_select_equip[text] = -1
		PlayerData.load_stats_from_equip()
		PlayerData.inventory.dict_select_equip[text]  = id
		upload_texture_equipped()
	$Stop_touch.visible = false
	$Popup_Notif.visible = false

func _on_cancel_pressed():
	$Stop_touch.visible = false
	$Popup_Notif.visible = false
