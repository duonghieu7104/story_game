extends Resource

class_name Inventory_weapon


@export var inventory_weapon = []
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

#value = -1: trống/ value = 0,1,2: chứa index
@export var dict_select_equip : Dictionary = {
	"slot1" : -1,
	"slot2" : -1,
	"slot3" : -1,
	"slot4" : -1,
	"slot5" : -1
}

@export var dict_select_equip_type : Dictionary = {
	"slot1" : -1,
	"slot2" : -1,
	"slot3" : -1,
	"slot4" : -1,
	"slot5" : -1
}

#them iteam vao list
func add_item_to_Inventory(item):
	inventory_weapon.append(item)

#tao iteam
#func generate_item(type : String, key1 : String, value1 : int, key2 : String, value2 : int):
#	var new_item = Weapon.new(type, key1, value1, key2, value2)
#	add_item_to_Inventory(new_item)

func generate_item(type : String, texture_path : String, stats : Dictionary):
	var new_item : Dictionary = {}
	new_item["type"] = type
	new_item["texture_path"] = texture_path
	for key in stats:
		new_item[key] = stats[key]
	add_item_to_Inventory(new_item)
