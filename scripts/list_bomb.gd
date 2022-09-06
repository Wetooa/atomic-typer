extends KinematicBody2D


# Declare member variables here. Examples:
const TIME_PERIOD = 0.01
var time = 0
var speed
onready var line_node = get_node("../input_line")
onready var gameplay_node = get_node("..")
onready var first_word_node = get_node("words_on_bomb")
onready var mid_word_node = get_node("words_on_bomb2")
onready var last_word_node = get_node("words_on_bomb3")
onready var short_node = get_node("short_bomb")
onready var mid_node = get_node("medium_bomb")
onready var last_node = get_node("last_bomb")
var random = RandomNumberGenerator.new()
var about_to_be_destroyed = false
var bomb_hp = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	# for generating the bomb on a random x coordinate
	random.randomize()
	set("position", Vector2((random.randi_range(300, 700)), -200))
	speed = gameplay_node.bomb_speed
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# for the time chunk of code
	if gameplay_node.pause == true:
		speed = 0
	else:
		speed = gameplay_node.bomb_speed / 3
		time += delta
		if time > TIME_PERIOD:
			move_and_slide(Vector2(0, speed), Vector2(0,-1))
			time = 0
		
		# to check if the current word in the input label is the same as any of the bombs
		# elif, then it checks the current x coordinate of the bomb
		if line_node.get_text().to_upper() == first_word_node.get_text():
			gameplay_node.score_add(1)
			last_node.hide()
			first_word_node.hide()
			mid_word_node.show()
		elif line_node.get_text().to_upper() == mid_word_node.get_text():
			gameplay_node.score_add(1)
			mid_node.hide()
			mid_word_node.hide()
			last_word_node.show()
		elif line_node.get_text().to_upper() == last_word_node.get_text():
			gameplay_node.score_add(2)
			about_to_be_destroyed = true
			queue_free()
		elif get("position").y >= 600:
			gameplay_node.minus_health()
			queue_free()
		
		
