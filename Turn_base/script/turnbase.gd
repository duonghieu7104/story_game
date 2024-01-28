extends Control

signal text_box

@export var name_enemy : String
@export var rank : int
@export var hp_max : int
@export var spd : int
@export var atk : int
@export var crichance : int
@export var cridamge : int
@export var avatar_path : String

func _ready():
	showMasage(" ")
	$VBoxContainer/Enemy.texture = load(avatar_path)

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

func showMasage(text):
	$TextHere.text = text

func _on_run_pressed():
	showMasage(" RUN ")
