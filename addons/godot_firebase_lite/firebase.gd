@tool
extends Node


const firebaseConfig : Dictionary = {
  "apiKey": "AIzaSyCSS2UgrD9cBLgOgvQl3VSyNTaWgHrYHSU",
  "authDomain": "chat-sys-4a69a.firebaseapp.com",
  "projectId": "chat-sys-4a69a",
  "storageBucket": "chat-sys-4a69a.appspot.com",
  "messagingSenderId": "41188183263",
  "appId": "1:41188183263:web:3e95cf135092f1cf9d6d6a",
"databaseURL": "https://chat-sys-4a69a-default-rtdb.asia-southeast1.firebasedatabase.app"
};

#Firebase Apps References
var initialized = false
var Authentication : Node
var RealtimeDatabase : Node
var Firestore : Node
#Other
var authToken = null

#Signals
signal firebaseInitialized

func initializeFirebase(FirebaseApps : Array, config : Dictionary = {}) -> void:
	if config == {}:
		config = firebaseConfig
	if initialized == true: pass
	var temporaryApp
	for app in FirebaseApps:
		match app:
			"Authentication": 
				temporaryApp = load("res://addons/godot_firebase_lite/Authentication/Authentication.tscn").instantiate()
			"Realtime Database":
				temporaryApp = load("res://addons/godot_firebase_lite/Realtime Database/RealtimeDatabase.tscn").instantiate()
			"Firestore":
				temporaryApp = load("res://addons/godot_firebase_lite/Firestore/Firestore.tscn").instantiate()
		temporaryApp.name = app
		self.add_child(temporaryApp)
		match app:
			"Authentication":
				Authentication = get_node(str(temporaryApp.name))
			"Realtime Database":
				RealtimeDatabase = get_node(str(temporaryApp.name))
			"Firestore":
				Firestore = get_node(str(temporaryApp.name))
	initialized = true

func terminateFirestore() -> void:
	self.queue_free()
