extends Control


# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_sign_up_pressed():
	var email = $Panel/email.text
	var password = $Panel/password.text
	await FirebaseLite.Authentication.initializeAuth(2, email, password )
	await FirebaseLite.Authentication.initializeAuth(3, email, password)
	var username = str(email).get_slice("@",0)
	await FirebaseLite.RealtimeDatabase.write("/chatrooms/users/"+username, {"email": email})
	
func _on_login_pressed():
	var email = $Panel/email.text
	var password = $Panel/password.text
	var error = await FirebaseLite.Authentication.initializeAuth(3, email, password)
	get_tree().change_scene_to_file("res://scenes/chat.tscn")
	$Label.text = str(error[1])
