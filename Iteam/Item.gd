extends Resource

class_name Item

@export var type : String
@export var stats : Dictionary = {}

func _init(type : String, key : String, value : int):
	stats[key] = value
