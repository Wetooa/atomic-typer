extends KinematicBody2D


# Declare member variables here. Examples:
const TIME_PERIOD = 0.01
var time = 0
var speed
onready var label_node = get_node("words_on_bomb")
onready var line_node = get_node("../input_line")
onready var gameplay_node = get_node("..")
var random = RandomNumberGenerator.new()
var about_to_be_destroyed = false


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
		speed = gameplay_node.bomb_speed
		time += delta
		if time > TIME_PERIOD:
			move_and_slide(Vector2(0, speed), Vector2(0,-1))
			time = 0
		
		# to check if the current word in the input label is the same as any of the bombs
		# elif, then it checks the current x coordinate of the bomb
		if line_node.get_text().to_upper() == label_node.get_text():
			gameplay_node.score_add(3)
			gameplay_node.current_words.erase(line_node.get_text().to_upper())
			about_to_be_destroyed = true
			queue_free()
		elif get("position").y >= 600:
			gameplay_node.minus_health()
			queue_free()
