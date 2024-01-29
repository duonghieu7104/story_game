extends Control

#Enemy
@export var name_enemy : String
@export var rank : int
@export var hp_max : int
@export var spd : int
@export var atk : float
@export var crichance : int
@export var cridamge : int
@export var avatar_path : String
@export var list_boss = []

#Player
@onready var player_hp_view = $"../../../../Player_scene/Bar/Health"
@onready var player_mana_view =  $"../../../../Player_scene/Bar/Mana"

#UI
@onready var hp_bar_view = $VBoxContainer/HealthBar
@onready var hp_count_view = $VBoxContainer/HealthBar/Health
@onready var name_enemy_view = $VBoxContainer/HealthBar/NameEnemy
@onready var texture_enemy_view = $VBoxContainer/Enemy

func _ready():
	$"../HBoxContainer/Menu_boss".get_popup().id_pressed.connect(send_path)

func _process(delta):
	pass

func load_enemy(path):
	var enemy = ResourceLoader.load(path)
	name_enemy = enemy.name
	rank = enemy.rank
	hp_max = enemy.hp_max
	spd = enemy.spd
	atk = enemy.atk
	crichance = enemy.crichance
	cridamge = enemy.cridamge
	avatar_path = enemy.avatar_path

func load_enemy_to_scene():
	player_hp_view.value = PlayerData.hp
	hp_bar_view.max_value = hp_max
	hp_bar_view.value = hp_max
	hp_count_view.text = "HP " + str(hp_bar_view.value) + "/" + str(hp_bar_view.max_value)
	name_enemy_view.text = name_enemy
	texture_enemy_view.texture = load(avatar_path)
	$Player/Action/Attack.disabled = true
	$Timer.wait_time = 3
	$Timer.start()

func send_path(id):
	load_enemy(list_boss[id])
	$".".visible = true
	load_enemy_to_scene()

func cri_chance_n_cridamge(atk : int, chance : int, damge : int):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var number = rng.randi_range (1, 100)
	if number <= chance:
		return atk * (100 + damge)/100
	return atk

func enemy_get_damge():
	var damge = cri_chance_n_cridamge(PlayerData.atk, PlayerData.crichange, PlayerData.cridamge)
	hp_bar_view.value -= damge
	print(damge)
	hp_count_view.text = "HP " + str(hp_bar_view.value) + "/" + str(hp_bar_view.max_value)
	$AnimationPlayer.play("enemy_get_damge")
	if hp_bar_view.value <= 0:
		$Enemy_cooldown.stop()
		$".".visible = false
		#reward

func enemy_take_damge():
	var damge = cri_chance_n_cridamge(atk, crichance, cridamge) - PlayerData.stats.def
	print("enemy: " + str(damge))
	player_hp_view.value -= damge
	if player_hp_view.value <= 0:
		$Enemy_cooldown.stop()
		$".".visible = false
		#LOSE
	else:
		set_time_enemy()

func _on_attack_pressed():
	enemy_get_damge()
	
func win_battle():
	pass

func lose_battle():
	pass

func _on_timer_timeout():
	$Player/Action/Attack.disabled = false
	enemy_take_damge()

func set_time_enemy():
	$Enemy_cooldown.wait_time = 4
	$Enemy_cooldown.start()

func _on_enemy_cooldown_timeout():
	enemy_take_damge()

func _on_button_pressed():
	enemy_take_damge()
