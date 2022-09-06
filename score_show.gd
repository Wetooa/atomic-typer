extends Label


onready var gameplay_node = get_node("../../gameplay_node")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("Score: " + str(gameplay_node.score))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
