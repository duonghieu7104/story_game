extends Control


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

func _process(delta):
	pass


func _on_login_pressed():
	PlayerData.coin.PlayerName = $Panel/username.text
	PlayerData.coin.mail = $Panel/mail.text
	PlayerData.save_data()
	var password = $Panel/Pass.text
	await FirebaseLite.Authentication.initializeAuth(2, PlayerData.coin.mail, password )
	await FirebaseLite.Authentication.initializeAuth(3, PlayerData.coin.mail, password)
	get_tree().change_scene_to_file("res://Main_scene/scene/Player_main_scene.tscn")
