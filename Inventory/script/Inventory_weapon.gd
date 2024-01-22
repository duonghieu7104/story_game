extends Resource

class_name Inventory_weapon

@export var inventory_weapon = []
@export var list_equip = []

var dict_select_equip : Dictionary = {
	"slot1" : 0,
	"slot2" : 0,
	"slot3" : 0,
	"slot4" : 0,
	"slot5" : 0,
}

#them iteam vao list
func add_item_to_Inventory(item):
	inventory_weapon.append(item)

#tao iteam
func generate_item(type : String, key1 : String, value1 : int, key2 : String, value2 : int):
	var new_item = Weapon.new(type, key1, value1, key2, value2)
	add_item_to_Inventory(new_item)
