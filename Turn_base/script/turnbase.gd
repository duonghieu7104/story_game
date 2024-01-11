extends Control

signal text_box

func _ready():
	showMasage(" ")

func _process(delta):
	pass

func showMasage(text):
	$TextHere.text = text

func _on_run_pressed():
	showMasage(" RUN ")
