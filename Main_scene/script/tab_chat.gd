extends TabBar

var chat_ui = preload("res://Chat/scene/Chat.tscn")

func _ready():
	FirebaseLite.initializeFirebase(["Authentication", "Firestore", "Realtime Database"], {
  "apiKey": "AIzaSyCSS2UgrD9cBLgOgvQl3VSyNTaWgHrYHSU",
  "authDomain": "chat-sys-4a69a.firebaseapp.com",
  "projectId": "chat-sys-4a69a",
  "storageBucket": "chat-sys-4a69a.appspot.com",
  "messagingSenderId": "41188183263",
  "appId": "1:41188183263:web:3e95cf135092f1cf9d6d6a",
"databaseURL": "https://chat-sys-4a69a-default-rtdb.asia-southeast1.firebasedatabase.app"
})
	if PlayerData.coin.PlayerName != "":
		await FirebaseLite.Authentication.initializeAuth(1)
		var instantiate_1 = chat_ui.instantiate()
		$".".add_child(instantiate_1)


func _process(delta):
	pass
