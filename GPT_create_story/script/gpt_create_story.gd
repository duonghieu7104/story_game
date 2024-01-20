extends Node

var api_key : String = "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"
var url : String = "https://api.openai.com/v1/chat/completions"
var temperature : float = 0.5
var max_tokens = 1024
var headers = ["Content-Type: application/json", "Authorization: Bearer " + api_key]
var model : String = "gpt-3.5-turbo"
var messages = []
var request : HTTPRequest
var scene_path = load("res://GPT_create_story/scene/chat_box.tscn")
var current_mess : String
var instances_array = []
var save_path = "user://conversations.json" 

func _ready():
	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)
	
	dialogue_request("")

func dialogue_request(player_dialogue):
	messages.append({
		"role": "user",
		"content": player_dialogue
	})
	var body = JSON.new().stringify({
		"messages": messages,
		"temperature": temperature,
		"max_tokens": max_tokens,
		"model": model,
	})
	
	var send_request = request.request(url, headers, HTTPClient.METHOD_POST, body)
	
	if send_request != OK:
		print("Error")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]
	#current_mess =
	print(message)
	#save_conversations_to_file(message)
	
	
	#var first_time : bool = true
	#if message == "CÓ" and first_time:
		#dialogue_request("BẮT ĐẦU")
		#first_time = false
	#else:
		#pass

func create_ui_for_gpt():
	pass

# Định nghĩa hàm để lưu các cuộc trò chuyện vào file
func save_conversations_to_file(data):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()
	print("Conversations saved to file.")

