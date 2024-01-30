extends Control

@onready var ui_inventory = $Tab_Menu/Inventory/Weapon_inventory/Weapon/VBoxContainer
@onready var ui_equipped = $Tab_Menu/Inventory/Equipped/Player_Eqiupped/Texture_equipped/Texture
@onready var ui_stats_view = $Tab_Menu/Inventory/Equipped/Player_Eqiupped/Texture_equipped/Stats
@onready var set_coin = $Player_scene/Bar/HBoxContainer/Coin

var box_weapon = preload("res://Inventory/scene/weapon_box.tscn")
var id : int

func _ready():
	#Inventory and stats
	PlayerData.load_data()
	set_coin.text = str(PlayerData.coin.coin)
	load_ui_inventory()
	upload_texture_equipped_n_stats_view()
	if ResourceLoader.exists("user://save_inventory.tres"):
		PlayerData.load_stats_from_equip()
	PlayerData.stats.load_stats()
	PlayerData.load_stats_to_current()
	
	
	#Turn base
	$Player_scene/Bar/Health.max_value = PlayerData.hp
	$Player_scene/Bar/Health.value = PlayerData.hp
	
	#Infor
	$Player_scene/Bar/HBoxContainer/Lv.text = "Lv: " + str(PlayerData.stats.lv)
	$Player_scene/Bar/HBoxContainer/Coin.text = str(PlayerData.coin.coin)

func _process(delta):
	pass

func load_ui_inventory():
	remove_all_children(ui_inventory)
	var i : int = -1
	for weapon in PlayerData.inventory.inventory_weapon:
		i += 1
		var instantiate = box_weapon.instantiate()
		ui_inventory.add_child(instantiate)
		instantiate.id = i
		instantiate.icon_equip.visible = weapon["equipped"]
		ui_inventory.get_child(i).connect("equip", equip_weapon_sword)
		ui_inventory.get_child(i).connect("sell", sell_iteam)
		var temp : String = ""
		for key in weapon.keys():
			if key in ["texture_path", "type", "equipped", "rank"]:
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
			ui_equipped.get_child(i).texture = load("res://Asset/icon_weapon/icon_null.jpg")
			ui_stats_view.get_child(i).text = ""
			continue
		var weapon = PlayerData.inventory.inventory_weapon[index]
		var path = weapon["texture_path"]
		var temp = ""
		for key_dict in weapon.keys():
			if key_dict in ["rank", "type", "texture_path", "equipped"]:
				continue
			temp += str(key_dict) + ": " + str(weapon[key_dict]) + " "
		ui_equipped.get_child(i).texture = load(path)
		ui_stats_view.get_child(i).text = temp

func _on_button_pressed():
	PlayerData.inventory.generate_item("dual_sword", "res://icon.svg", 45, false,{"atk" : 5})
	PlayerData.inventory.generate_item("dual_sword", "res://icon.svg", 45, false,{"def" : 6})
	PlayerData.inventory.generate_item("dual_sword", "res://icon.svg", 45, false,{"spd" : 7})
	load_ui_inventory()

func _on_button_2_pressed():
	PlayerData.save_data()

func equip_in_slot(text : String):
	var ok = PlayerData.inventory.inventory_weapon[id]["equipped"]
	print(!ok)
	if !ok:
		if PlayerData.inventory.dict_select_equip[text] != -1:
			var temp = PlayerData.inventory.dict_select_equip[text]
			PlayerData.inventory.inventory_weapon[temp]["equipped"] = false
		PlayerData.inventory.dict_select_equip[text] = id
		show_notif("text notif", "Đã trang bị thành công")
		PlayerData.inventory.inventory_weapon[id]["equipped"] = true
	load_ui_inventory()
	PlayerData.load_stats_from_equip()
	PlayerData.load_stats_to_current()
	upload_texture_equipped_n_stats_view()
	

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
			$Stop_touch.visible = true
			$Equip_dual.visible = true
	
	elif type_weapon == "helmet":
		equip_in_slot("slot3")
	
	elif type_weapon == "armor":
		equip_in_slot("slot4")
	
	elif type_weapon == "boots":
		equip_in_slot("slot5")
		
	upload_texture_equipped_n_stats_view()
	load_ui_inventory()

func show_notif(type_notif : String, message : String):
	if  type_notif == "un equipped notif":
		$Stop_touch.visible = true
		$Panel.visible = true
		$Panel/VBoxContainer/Label.text = message
	elif type_notif == "text notif":
		$Text_notif.text = message

func _on_ok_pressed():
	$Stop_touch.visible = false
	$Panel.visible = false


func _on_unslot_1_pressed():
	un_equip("slot1")


func _on_unslot_2_pressed():
	un_equip("slot2")


func _on_unslot_3_pressed():
	un_equip("slot3")


func _on_unslot_4_pressed():
	un_equip("slot4")


func _on_unslot_5_pressed():
	un_equip("slot5")


func un_equip(text : String):
	var temp = PlayerData.inventory.dict_select_equip[text]
	PlayerData.inventory.inventory_weapon[temp]["equipped"] = false
	PlayerData.inventory.dict_select_equip[text] = -1
	load_ui_inventory()
	PlayerData.load_stats_to_current()
	upload_texture_equipped_n_stats_view()


func _on_slot_1_pressed():
	equip_in_slot("slot1")
	$Stop_touch.visible = false
	$Equip_dual.visible = false


func _on_slot_2_pressed():
	equip_in_slot("slot2")
	$Stop_touch.visible = false
	$Equip_dual.visible = false


func _on_cancel_pressed():
	$Stop_touch.visible = false
	$Equip_dual.visible = false

func sell_iteam(index_ivt):
	if PlayerData.inventory.inventory_weapon[index_ivt]["equipped"] == false:
		PlayerData.coin.coin += PlayerData.inventory.inventory_weapon[index_ivt]["rank"]*3
		PlayerData.inventory.inventory_weapon.remove_at(index_ivt)
		set_coin.text = str(PlayerData.coin.coin)
		load_ui_inventory()


func _on_button_4_pressed():
	PlayerData.get_exp(50)

#Get Item Random

