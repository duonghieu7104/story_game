extends Control

@onready var ui_inventory = $main_scene/Inventory/ScrollContainer/VBoxContainer
var box_weapon = preload("res://Inventory/scene/equip_box.tscn")

func _ready():
	for i in 100:
		var instantiate = box_weapon.instantiate()
		ui_inventory.add_child(instantiate)

func _process(delta):
	pass
