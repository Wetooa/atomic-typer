extends Button


# Declare member variables here. Examples:
onready var gameplay_node = get_node("..")
onready var pause_node = get_node("../pause2")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _pressed():
	if gameplay_node.pause == false:
		gameplay_node.pause = true
		pause_node.show()
	else:
		gameplay_node.pause = false
		pause_node.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
