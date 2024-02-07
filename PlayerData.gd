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
	ResourceSaver.save(coin, save_file_path + save_file_name_coin)

func load_data():
	if ResourceLoader.exists(save_file_path + save_file_name_inventory) and ResourceLoader.exists(save_file_path + save_file_name_stats) and ResourceLoader.exists(save_file_path + save_file_name_coin):
		print("Da Load")
		inventory = ResourceLoader.load(save_file_path + save_file_name_inventory).duplicate(true)
		stats = ResourceLoader.load(save_file_path + save_file_name_stats).duplicate(true)
		coin = ResourceLoader.load(save_file_path + save_file_name_coin).duplicate(true)
	else:
		print("Khong tim thay file")

#Stats
@export var hp : int 
@export var mana : int
@export var atk : int
@export var s_atk : int
@export var def : int
@export var spd : int
@export var crichance : int
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
	stats.load_stats()
	load_stats_from_equip()
	hp = stats.hp + list_equipped["hp"]
	mana = stats.mana + list_equipped["mana"]
	atk = stats.atk + list_equipped["atk"]
	s_atk = stats.s_atk + list_equipped["s_atk"]
	spd = stats.spd + list_equipped["spd"]
	def = stats.def + list_equipped["def"]
	crichance = stats.crichance + list_equipped["crichance"]
	cridamge = stats.cridamge + list_equipped["cridamge"]


#Lv + exp
func get_exp(exps : int):
	stats.exp_current += exps
	while stats.exp_current >= stats.exp_total:
		stats.lv += 1
		stats.exp_current -= stats.exp_total
		stats.exp_total = stats.exp_total * 1.02
	stats.load_stats()
	load_stats_to_current()
	
