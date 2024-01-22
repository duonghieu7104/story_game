extends Resource

class_name Weapon

@export var type : String
@export var stats : Dictionary = {}

func _init(type : String, key1 : String, value1 : int, key2 : String, value2 : int):
	stats[key1] = value1
	stats[key2] = value2
