extends Control

@onready var ui_inventory = $Tab_Menu/Inventory/Weapon_inventory/Weapon/VBoxContainer
@onready var ui_equipped = $Tab_Menu/Inventory/Equipped/Player_Eqiupped/Texture_equipped/Texture
@onready var ui_stats_view = $Tab_Menu/Inventory/Equipped/Player_Eqiupped/Texture_equipped/Stats
var box_weapon = preload("res://Inventory/scene/weapon_box.tscn")
var id : int

func _ready():
	PlayerData.load_data()
	load_ui_inventory()
	upload_texture_equipped_n_stats_view()
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

func remove_all_children(parent):
	var children = parent.get_children()
	for child in children:
		parent.remove_child(child)

func upload_texture_equipped_n_stats_view():
	var i : int = -1
	for key in PlayerData.inventory.dict_select_equip.keys():
		i += 1
		var index = PlayerData.inventory.dict_select_equip[key]
		if index == -1:
			continue
			#ui_equipped.get_child(i).texture = load(path_slot_null)
		var weapon = PlayerData.inventory.inventory_weapon[index]
		var path = weapon["texture_path"]
		var temp = ""
		for key_dict in weapon.keys():
			if key_dict in ["rank", "type", "texture_path"]:
				continue
			temp += str(key_dict) + ": " + str(weapon[key_dict]) + " "
		ui_equipped.get_child(i).texture = load(path)
		ui_stats_view.get_child(i).text = temp
		PlayerData.load_stats_from_equip()

func _on_button_pressed():
	PlayerData.inventory.generate_item("sword", "res://icon.svg", 45, {"atk" : 5})
	PlayerData.inventory.generate_item("shield", "res://icon.svg", 45, {"atk" : 5})
	PlayerData.inventory.generate_item("dual_sword", "res://icon.svg", 45, {"atk" : 5})
	load_ui_inventory()

func _on_button_2_pressed():
	PlayerData.save_data()

func equip_in_slot(text : String):
	PlayerData.inventory.dict_select_equip[text] = id

func equip_weapon_sword(index_ivt):
	id = index_ivt
	var type_weapon = PlayerData.inventory.inventory_weapon[id]["type"]
	var check = PlayerData.inventory.dict_select_equip
	
	if type_weapon == "sword":
		if check["slot2"] == -1 or PlayerData.inventory.inventory_weapon[check["slot2"]]["type"] == "shield":
			if check["slot1"] == -1:
				equip_in_slot("slot1")
			else:
				show_notif("un equipped notif", "Hãy gỡ trang bị ở tay phải để tiếp tục")
		else:
			show_notif("un equipped notif", "Hãy gỡ trang bị ở tay trái để tiếp tục")
	
	elif type_weapon == "shield":
		if check["slot1"] == -1 or PlayerData.inventory.inventory_weapon[check["slot1"]]["type"] == "sword":
			if check["slot2"] == -1:
				equip_in_slot("slot2")
			else:
				show_notif("un equipped notif", "Hãy gỡ trang bị ở tay trái để tiếp tục")
		else:
			show_notif("un equipped notif", "Hãy gỡ trang bị ở tay phải để tiếp tục")
	
	elif type_weapon == "oh_sword":
		if check["slot2"] == -1:
			if check["slot1"] == -1:
				equip_in_slot("slot1")
			else:
				show_notif("un equipped notif", "Hãy gỡ trang bị ở tay phải để tiếp tục")
		else:
			show_notif("un equipped notif", "Hãy gỡ trang bị ở tay trái để tiếp tục")
	
	elif type_weapon == "dual_sword":
		if PlayerData.inventory.inventory_weapon[check["slot1"]]["type"] != "dual_sword" or PlayerData.inventory.inventory_weapon[check["slot2"]]["type"] != "dual_sword":
			show_notif("un equipped notif", "Hãy gỡ trang bị ở tay phải/ trái để tiếp tục")
		else:
			if PlayerData.inventory.dict_select_equip["slot1"] != -1:
				equip_in_slot("slot2") 
			else:
				equip_in_slot("slot1")
	upload_texture_equipped_n_stats_view()

func show_notif(type_notif : String, message : String):
	if  type_notif == "un equipped notif":
		$Stop_touch.visible = true
		$Panel.visible = true
		$Panel/VBoxContainer/Label.text = message
	elif type_notif == "text notif":
		$Text_notif.text = message

func un_equip_slot_1n2():
	PlayerData.inventory.dict_select_equip["slot1"] = -1
	PlayerData.inventory.dict_select_equip["slot1"] = -2

func _on_out_pressed():
	un_equip_slot_1n2()

func _on_ok_pressed():
	$Stop_touch.visible = false
	$Panel.visible = false
