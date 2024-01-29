extends Node

#file path
var save_file_path = "user://save_"
var save_file_name_inventory = "inventory.tres"
var save_file_name_stats = "stats.tres"
var save_file_name_coin = "coin.tres"

#Object
var inventory = Inventory_weapon.new()
var stats = Stats.new()
var coin = Coin.new()

#Func item
func generate_item(type : String, texture_path : String, rank: int, equipped : bool,stats : Dictionary):
	inventory.generate_item(type, texture_path, rank, equipped,stats)

func save_data():
	ResourceSaver.save(inventory, save_file_path + save_file_name_inventory)
	ResourceSaver.save(stats, save_file_path + save_file_name_stats)

func load_data():
	if ResourceLoader.exists(save_file_path + save_file_name_inventory):
		print("Da Load")
		inventory = ResourceLoader.load(save_file_path + save_file_name_inventory).duplicate(true)
	else:
		print("Khong tim thay file")

#Stats
@export var hp : int 
@export var mana : int
@export var atk : int
@export var s_atk : int
@export var def : int
@export var spd : int
@export var crichange : int
@export var cridamge : int

@export var list_equipped : Dictionary = {
	"atk" : 0,
	"s_atk" : 0,
	"hp" : 0,
	"mana" : 0,
	"def" : 0,
	"spd" : 0,
	"cridamge" : 0,
	"crichance" : 0
}

func load_stats_from_equip():
	for key in list_equipped.keys():
		list_equipped[key] = 0
	for key in list_equipped.keys():
		for index in inventory.dict_select_equip.keys():
			var idx = inventory.dict_select_equip[index]
			if idx == -1:
				continue
			var temp = inventory.inventory_weapon[idx]
			if key in temp:
				list_equipped[key] += temp[key]
	

func load_stats_to_current():
	hp = stats.hp + list_equipped["hp"]
	atk = stats.atk + list_equipped["atk"]
