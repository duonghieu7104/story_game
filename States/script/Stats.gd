extends Resource

class_name Stats

#Lv + Exp
@export var lv : int = 1
@export var exp_total = 100
@export var exp_current = 0

#Growth
@export var growth_hp : int = 2
@export var growth_mana : int = 2
@export var growth_atk : int = 2
@export var growth_s_atk : int = 2
@export var growth_def : int = 2
@export var growth_spd : int = 2


#Stats no equip
@export var hp : int
@export var mana : int
@export var atk : int
@export var s_atk : int
@export var def : int
@export var spd : int
@export var crichance : int
@export var cridamge : int

func load_stats():
	hp = 20 + lv * growth_hp
	atk = 10 + lv * growth_atk
	s_atk = 15 + lv * growth_s_atk
	mana = 15 + lv * growth_mana
	spd = 5 + lv * growth_spd
	def = 0 + lv * growth_def
	crichance = 0
	cridamge = 0
