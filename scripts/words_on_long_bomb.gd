extends Label


# Declare member variables here. Examples:
var random = RandomNumberGenerator.new()
onready var bomb_node = get_node("..")
onready var gameplay_node = get_node("../..")
var words

# Called when the node enters the scene tree for the first time.
func _ready():
	# randomizing random :D 
	random.randomize()
	
	# accessing the words that were called on a different node
	words = gameplay_node.long_words
	
	# getting a random word in the var words
	var random_word = words[random.randi_range(0, len(words)-1)]
	gameplay_node.add_array(random_word)
	set_text(random_word.to_upper())
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
