extends Button

@onready var weapon_view = $Weapon_view
@onready var btn_view = $Btn_view
@onready var stats_view = $Weapon_view/Stats
@onready var texture_view = $Weapon_view/Texture
@onready var icon_equip = $Equipped
@export var id : int

signal equip (index_ivt)
signal sell (index_ivt)

func _ready():
	pass

func _process(delta):
	pass

func _on_pressed():
	weapon_view.visible = false
	btn_view.visible = true


func _on_cancel_pressed():
	weapon_view.visible = true
	btn_view.visible = false


func _on_equip_pressed(): #equip
	emit_signal("equip", id)
	weapon_view.visible = true
	btn_view.visible = false


func _on_sell_pressed():
	emit_signal("sell", id)
