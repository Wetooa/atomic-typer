extends Node


# Declare member variables here. Examples:
var time_period_bomb_spawn = 3
var bomb_speed = 40
var time = 0
var diff_time = 0
onready var input_node = get_node("input_line")
onready var score_node = get_node("score_display")
onready var hp_node = get_node("hp_display")
onready var points_sfx_node = get_node("add_score_sfx")
onready var minus_health_sfx_node = get_node("bomb_drops_sfx")
# onready var tint_node = get_node("tint_canvas")
onready var highscore_node = get_node("highscore_display")
onready var global_timer_node = get_node("global_timer_display")
var score = 0
var hp = 3
var current_words = []
var words
var short_words = []
var medium_words = []
var long_words = []
var bomb_spawn_diff = 0
var bomb_spawn
var random = RandomNumberGenerator.new()
var pause = false
var sound_has_played = false
var highscore
var global_timer = 0
var list_timer = 0
const LIST_SPAWN_PERIOD = 20
var number_bomb_spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	# accessing the file
	var f = File.new()
	f.open("res://testing_dict.txt", File.READ)
	words = f.get_line().split(",")
	for x in words:
		if len(x) < 6: 
			short_words.append(x.to_upper())
		elif len(x) < 8: 
			medium_words.append(x.to_upper())
		elif len(x) < 9: 
			long_words.append(x.to_upper())
	f.close()
	
	f.open("res://leaderboard.txt", File.READ)
	highscore = f.get_line().split(",")[0].split(":")[1]
	highscore_node.set_text("Highscore: " + str(highscore))
	f.close()
	
	# creating the first bomb
	var bomb_scene = load("res://short_bomb.tscn")
	var bomb = bomb_scene.instance()
	add_child(bomb)
	random.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# adjusts difficulty
	if pause == true:
		pass
	else:
		# global timer to keep track of time
		global_timer += delta
		global_timer_node.set_text("Timer: " + str("%*.*f" % [0, 2, global_timer]))
		
		# rise in difficulty
		diff_time += delta
		if diff_time > 1:
			if bomb_speed < 60:
				bomb_speed += 0.4
			if time_period_bomb_spawn > 2.5:
				time_period_bomb_spawn -= 0.001
			diff_time = 0
		
		# timer for bomb spawning
		bomb_spawn_diff += delta
		time += delta
		if time > time_period_bomb_spawn:
			
			# chance for bombs to spawn twice
			number_bomb_spawn = random.randi_range(0,100)
			if number_bomb_spawn < 80:
				number_bomb_spawn = 1
			else:
				number_bomb_spawn = 2
			
			# spawning of the bombs based on time passed
			bomb_spawn = random.randi_range(0, 100)
			while number_bomb_spawn != 0:
				if bomb_spawn_diff < 60:
					if bomb_spawn < 75:
						spawn_short()
					else: 
						spawn_mid()
				elif bomb_spawn_diff < 120:
					if bomb_spawn < 95: 
						spawn_mid()
					else: 
						spawn_long()
				elif bomb_spawn_diff >= 120: 
					spawn_long()
				number_bomb_spawn -= 1
			time = 0
		
		list_timer += delta
		if list_timer > LIST_SPAWN_PERIOD:
			spawn_list()
			list_timer = 0
		
		# function to insta clear the input bar
		if Input.is_action_just_pressed("clear"):
			input_node.set_text("")
		
		if hp < 3:
			hp_node.get_node("heart3").hide()
			get_node("animated_fire1").show()
		if hp < 2:
			hp_node.get_node("heart2").hide()
			get_node("animated_fire2").show()
		if hp < 1:
			# tint canvas for better effect
			# tint_node.show()
			
			hp_node.get_node("heart1").hide()
			get_node("animated_fire3").show()
			
			# pauses the game
			pause = true
			input_node.set_editable(false)

# adds the word attached by the newly instantiated bomb
func add_array(random_word):
	current_words.append(random_word.to_upper())

# adds points for every successful defuse
func score_add(points):
	# play sound, also reimported it to not loop
	points_sfx_node.play()
	
	# add points
	score += points
	score_node.set_text("Score: " + str(score))
	input_node.set_text("")

# minus health function that is called in another script
# minus health once the bomb has travelled a certain distance
func minus_health():
	# play sound
	minus_health_sfx_node.play(0.2)
	
	# minus health
	hp -= 1
	
func spawn_short():
	var bomb_scene = load("res://short_bomb.tscn")
	var bomb = bomb_scene.instance()
	add_child(bomb)

func spawn_mid():
	var bomb_scene = load("res://medium_bomb.tscn")
	var bomb = bomb_scene.instance()
	add_child(bomb)
	
func spawn_long():
	var bomb_scene = load("res://long_bomb.tscn")
	var bomb = bomb_scene.instance()
	add_child(bomb)

func spawn_list():
	var bomb_scene = load("res://list_bomb.tscn")
	var bomb = bomb_scene.instance()
	add_child(bomb)

func _unhandled_input(event):
	if event is InputEventKey and pause == false:
		if event.pressed and event.scancode != 16777221:
			print(event.scancode)
			if event.scancode == 16777220:
				var current_text = input_node.get_text()
				current_text.erase(len(current_text)-1, 1)
				input_node.set_text(current_text)
			elif event.scancode >= 65 and event.scancode <= 90:
				input_node.set_text(input_node.get_text() + char(event.scancode))
				
				
