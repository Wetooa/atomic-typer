extends LineEdit


# Declare member variables here. Examples:
onready var gameplay_node = get_node("../../gameplay_node")
onready var game_over_node = get_node("..")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_text = get_text()
	if Input.is_action_just_pressed("enter") and current_text != "" and !" " in current_text:
		game_over_node.append_score(current_text.to_upper(), gameplay_node.score)
		set_editable(false)
