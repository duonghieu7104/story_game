extends Node

@export var list = load("res://Inventory/script/Inventory.tres")

func _ready():
	list.add_item(load("res://Iteam/Sword.tres"))
