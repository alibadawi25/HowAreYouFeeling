extends Node2D

@onready var text_edit = $TextEdit
@onready var button = $Button
@onready var music = $AudioStreamPlayer2D

var happy = [
	"res://Music/Taylorrrr.wav",
	"res://Music/Sponge Pop Lofi 3 final.wav",
	"res://Music/Avicii - The Nights (Lyrics) ＂my father told me＂.wav",
	"res://Music/Arabic House Beat updated.wav",
	"res://Music/Avicii - Wake Me Up (Official Lyric Video).wav",
	"res://Music/Beat afro raye2 fash5.wav"
]

var sad = [
	"res://Music/abyu legecy.wav",
	"res://Music/Basrah w atoh finish.wav",
	"res://Music/Conan Gray - Memories (Lyrics).wav",
	"res://Music/interstellar lofi remix 2.wav",
	"res://Music/Lege-Cy - Betadeen ｜ ليجي-سي - بيتادين (Official Audio).wav",
	"res://Music/Lege-Cy - Fel Galeed ｜ ليجي-سي - في الجليد (Official Audio).wav",
	"res://Music/Sweater Weather.wav",
	"res://Music/The Neighbourhood - Daddy Issues (Remix).wav"
]

var confused = [
	"res://Music/Basrah w atoh finish.wav",
	"res://Music/abyu legecy.wav",
	"res://Music/Beach House - Space Song.wav",
	"res://Music/Everything I wanted Remix.wav",
	"res://Music/interstellar lofi remix 2.wav",
	"res://Music/beat gamed moottt 7th examsss.wav",
	"res://Music/Sweater Weather.wav",
	"res://Music/The Neighbourhood - Afraid (Official Audio).wav",
	"res://Music/The Neighbourhood - Daddy Issues (Remix).wav"
]

var calm = [
	"res://Music/Sponge Pop Lofi 3 final.wav",
	"res://Music/interstellar lofi remix 2.wav",
	"res://Music/Beach House - Space Song.wav",
	 "res://Music/Beat afro raye2 fash5.wav",
	"res://Music/Conan Gray - Memories (Lyrics).wav",
]

var energetic = [
	"res://Music/Avicii - The Nights (Lyrics) ＂my father told me＂.wav",
	"res://Music/Arabic House Beat updated.wav",
	"res://Music/Avicii - Wake Me Up (Official Lyric Video).wav",
	"res://Music/abyu legecy.wav"
]

var vibe = [
	"res://Music/Beach House - Space Song.wav",
	"res://Music/Sweater Weather.wav",
	"res://Music/beat gamed moottt 7th examsss.wav",
	"res://Music/Everything I wanted Remix.wav",
	"res://Music/abyu legecy.wav",
	"res://Music/The Neighbourhood - Afraid (Official Audio).wav",
	"res://Music/The Neighbourhood - Daddy Issues (Official Video).wav"
]

func _on_button_pressed():
	var user_text = text_edit.text.to_lower()
	var mood = analyze_mood(user_text)
	var secondary_mood = analyze_secondary_mood(user_text)
	play_song_for_mood(mood, secondary_mood)

func analyze_mood(text):
	var happy_keywords = ["happy", "joy", "excited", "fun", "pleased", "delighted", "ecstatic", "thrilled", "cheerful", "content", "better", "good", "great", "positive", "in love", "loving", "elated", "overjoyed", "blissful"]
	var sad_keywords = ["sad", "down", "unhappy", "depressed", "melancholy", "sorrow", "mournful", "gloomy", "heartbroken", "heart broken", "despair", "worse", "bad", "terrible", "negative", "lonely", "alone", "broken", "fail", "failed", "failing", "failure", "miserable", "hopeless", "dejected", "downcast"]
	var confused_keywords = ["confused", "puzzled", "uncertain", "doubtful", "lost", "bewildered", "perplexed", "disoriented", "baffled", "flustered", "unsure", "mixed feelings", "confounding", "unclear", "ambivalent"]

	var happy_expressions = ["feeling good", "on top of the world", "can't complain", "feeling great"]
	var sad_expressions = ["feeling down", "in the dumps", "can't go on", "feeling blue"]
	var confused_expressions = ["at a loss", "at sea", "all mixed up", "don't know what to do"]

	var happy_count = 0
	var sad_count = 0
	var confused_count = 0

	for word in text.split(" "):
		if word in happy_keywords:
			happy_count += 1
		elif word in sad_keywords:
			sad_count += 1
		elif word in confused_keywords:
			confused_count += 1

	for expr in happy_expressions:
		if expr in text:
			happy_count += 2  
	for expr in sad_expressions:
		if expr in text:
			sad_count += 2 
	for expr in confused_expressions:
		if expr in text:
			confused_count += 2 

	if happy_count > sad_count and happy_count > confused_count:
		return "happy"
	elif sad_count > happy_count and sad_count > confused_count:
		return "sad"
	elif confused_count > happy_count and confused_count > sad_count:
		return "confused"

	return "happy"

func analyze_secondary_mood(text):
	var calm_keywords = ["calm", "relaxed", "soothing", "peaceful", "serene", "quiet", "tranquil", "chill", "gentle", "sleepy", "asleep", "sleep"]
	var energetic_keywords = ["energetic", "lively", "active", "dynamic", "vibrant", "enthusiastic", "spirited", "pumped", "hyped"]

	for word in text.split(" "):
		if word in calm_keywords:
			return "calm"
		elif word in energetic_keywords:
			return "energetic"
			
	return ""

func play_song_for_mood(mood, secondary_mood):
	var songs = []

	match mood:
		"happy":
			songs = happy
		"sad":
			songs = sad
		"confused":
			songs = confused

	if secondary_mood == "calm":
		songs = get_intersection(songs, calm)
	elif secondary_mood == "energetic":
		songs = get_intersection(songs, energetic)

	if songs.size() == 0:
		match mood:
			"happy":
				songs = happy
			"sad":
				songs = sad
			"confused":
				songs = confused

	if songs.size() == 0:
		songs = get_combined_unique_list(happy, sad, confused)

	if songs.size() > 0:
		var random_index = randi() % songs.size()
		music.stream = load(songs[random_index])
		music.play()

func get_intersection(array1, array2):
	var intersection = []
	for item in array1:
		if item in array2:
			intersection.append(item)
	return intersection

func get_combined_unique_list(array1, array2, array3):
	var combined = array1 + array2 + array3
	var unique_combined = []
	for item in combined:
		if item not in unique_combined:
			unique_combined.append(item)
	return unique_combined
