extends Node2D

@onready var option_button = $Panel/OptionButton
@onready var option_button_2 = $Panel/OptionButton2
@onready var option_button_3 = $Panel/OptionButton3
@onready var option_button_4 = $Panel/OptionButton4
@onready var button = $Panel/Button
@onready var popup = $Popup
@onready var popup_label = $Popup/Label
@onready var close_button = $Popup/CloseButton
@onready var music = $AudioStreamPlayer2D
@onready var button_2 = $Panel/Button2

var happy = ["res://Music/Taylorrrr.wav","res://Music/Sponge Pop Lofi 3 final.wav","res://Music/Avicii - The Nights (Lyrics) ＂my father told me＂.wav","res://Music/Arabic House Beat updated.wav","res://Music/Avicii - Wake Me Up (Official Lyric Video).wav"]
var sad = ["res://Music/abyu legecy.wav","res://Music/Basrah w atoh finish.wav","res://Music/Conan Gray - Memories (Lyrics).wav","res://Music/interstellar lofi remix 2.wav"]
var confused = ["res://Music/Basrah w atoh finish.wav","res://Music/abyu legecy.wav","res://Music/Beach House - Space Song.wav","res://Music/Everything I wanted Remix.wav","res://Music/interstellar lofi remix 2.wav"]
var calm = []
var energetic = []
var angry = []
var play = false
var music_playing = false

func _process(delta):
	if play and not music_playing:
		play_random_song()
		music_playing = true
	elif not play and music_playing:
		stop_music()
		music_playing = false

func play_random_song():
	var songs = []
	match option_button.selected:
		0:
			songs = happy
		1:
			songs = sad
		2:
			songs = confused
		# Add more cases as needed for other options
	if songs.size() > 0:
		var random_index = randi() % songs.size()
		music.stream = load(songs[random_index])
		music.play()

func stop_music():
	music.stop()

func _on_button_pressed():
	if _all_option_buttons_filled():
		play = true
		button_2.visible = true
		button.visible = false
	else:
		popup_label.text = "Please fill all option buttons."
		popup.popup_centered()

func _all_option_buttons_filled() -> bool:
	return option_button.selected != -1 

func _on_close_button_pressed():
	popup.visible = false


func _on_button_2_pressed():
	music_playing = false
