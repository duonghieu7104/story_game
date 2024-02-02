extends Control

@onready var http = $HTTPRequest
var nameee = "hieuduong"
var sheetname = "CHAT"
var headers = ["Content-Length: 0"]
var apiurl = "https://script.google.com/macros/s/AKfycbyp433HcI_6rQYwoMVKqNDouGmkHbq3mJ0eu4g6rUVKG3pXyGWxe_NOGQc0NgGM088-_Q/exec"
var geturl = apiurl+"?sheetname="+sheetname
var is_requesting = false
var pending_request = null 

func _ready():
	repeat()

func getdata():
	if not is_requesting:
		is_requesting = true
		$HTTPRequest.request(geturl)

func _on_button_pressed():
	var messee = str($Mess.text)
	$Mess.text = ""
	var datasend = "?nameee="+nameee+"&messee="+messee+"&sheetname="+sheetname
	var headers = ["Content-Length: 0"]
	var posturl = apiurl+datasend
	if not is_requesting:
		is_requesting = true
		$HTTPRequest.request(posturl,headers, HTTPClient.METHOD_POST)
	else:
		pending_request = [posturl, headers, HTTPClient.METHOD_POST]


func _on_button_2_pressed():
	getdata()

func _on_http_request_request_completed(result, response_code, headers, body):
	is_requesting = false
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.get_data()
	print(data)
	if data == null:
		return
	$ScrollContainer/TextEdit.text = ""	
	for element in data:
		for i in element.keys():
			$ScrollContainer/TextEdit.text += str(element[i]) + "\t"
		$ScrollContainer/TextEdit.text += "\n"
	if pending_request != null:
		is_requesting = true
		$HTTPRequest.request(pending_request[0], pending_request[1], pending_request[2])
		pending_request = null

func get_data():
	if not is_requesting:
		is_requesting = true
		$HTTPRequest.request(geturl)

func repeat():
	var timer = get_tree().create_timer(2)
	await timer.timeout
	getdata()
	repeat()
