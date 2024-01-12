extends Node

var api_key : String = "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"
var url : String = "https://api.openai.com/v1/chat/completions"
var temperature : float = 0.5
var max_tokens = 1024
var headers = ["Content-Type: application/json", "Authorization: Bearer " + api_key]
var model : String = "gpt-3.5-turbo"
var messages = []
var request : HTTPRequest

func _ready():
	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)
	
	dialogue_request("Từ bây giờ bạn sẽ  là AI chuyên viết cốt truyện, nhiệm vụ của bạn là tạo ra các tình huống cho game buộc người chơi phải lựa chọn hướng giải quyết. 
					Cốt  truyện bạn viết và việc bạn cần làm sẽ được tôi làm rõ ngay sau đây:

					Cốt truyện sẽ về thế giới Fantasy, người chơi sẽ đóng vai nhân vật chính được triệu hồi đến dị giới (Isekai). 
					Việc của bạn là viết cốt truyện, tạo nhiệm vụ liên quan đến cốt truyện chính hoặc xoay quanh cốt truyện chính, 
					có thể sẽ có những nhiệm vụ ngoại cốt truyện chính (nhưng hãy thật hạn chế).
					Bạn sẽ tạo ra tình huống và đưa cho người chơi các lựa chọn (Từ 2 trở lên, tùy vào tình huống). 
					Việc của người chơi là trả lời chọn Lựa chọn nào. Ví dụ:

					Bạn:
							#Một sự kiện gì đó xảy ra#
									#A. Lựa chọn A#
									#B. Lựa chọn B#
									#C. Lựa chọn C#
									
									
					(Lưu ý: Tình huống/ Câu truyện/ Sự kiện và các Lựa chọn phải đặt giữa hai dấu thăng #...#)


					Người chơi:
									A hoặc Lựa chọn A

					Người chơi có thể trả lời nhiều kiểu nhưng đại ý phải là chọn 1 trong các lựa chọn.
					Và sẽ bắt đầu hành động thì tôi nói: BẮT ĐẦU.
					Nếu bạn đã hiểu các yêu cầu của tôi thì hãy trả lời: CÓ 
	")

func dialogue_request(player_dialogue):
	messages.append({
		"role": "user",
		"content": player_dialogue
	})
	var body = JSON.new().stringify({
		"messages": messages,
		"temperature": temperature,
		"max_tokens": max_tokens,
		"model": model
	})
	
	var send_request = request.request(url, headers, HTTPClient.METHOD_POST, body)
	
	if send_request != OK:
		print("Error")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]
	if message == "CÓ":
		pass
	print(message)
