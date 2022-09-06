extends Button


# Declare member variables here. Examples:
var score_sort_descending = false
onready var leaderboard_node = get_node("..")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	if score_sort_descending == false:
		leaderboard_node.sort_score(score_sort_descending)
		score_sort_descending = true
	else:
		leaderboard_node.sort_score(score_sort_descending)
		score_sort_descending = false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
