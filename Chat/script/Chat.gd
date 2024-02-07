extends Control

var data = ""
var email = ""
var UID = ""
var nickname = ""
var activechat = "/chatrooms/global"
var initreq = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	nickname = PlayerData.coin.PlayerName
	get_chatrooms()
	
	FirebaseLite.RealtimeDatabase.connect("refUpdated",chatmanager)
	await FirebaseLite.RealtimeDatabase.listen(activechat)


func get_chatrooms():
	var rooms = await FirebaseLite.RealtimeDatabase.read("/chatrooms/users")
	print(rooms)

func _on_chatrooms_item_activated(index):
	pass
	#activechat = $chatrooms.get_item_text(index)
	#FirebaseLite.RealtimeDatabase.listen(activechat)

func _on_send_pressed():
	var msg = $messege.text
	$messege.text = ""
	await FirebaseLite.RealtimeDatabase.push(activechat,{nickname:msg})


func chatmanager(req):
	if req["data"] != null:
		var chats = req["data"]
		print(chats)
	# because at first it gets all data
	# laterwards only changes , thats why
		var timestamps = chats.keys()
		if initreq == 0:
			for i in timestamps:
				var sender = chats[i].keys()[0]
				var msg = chats[i][sender]
				$Panel/chat.add_item(sender+": "+msg)
			initreq = initreq+1
		else:
		#print(chats)
			for i in timestamps:
				var sender = i
				var msg = chats[i]
				$Panel/chat.add_item(sender+": "+msg)

