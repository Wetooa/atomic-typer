extends Node


onready var gameplay_node = get_node("gameplay_node")
var lose = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gameplay_node.hp < 1 and lose == false:
		var game_over_scene = load("res://game_over.tscn")
		var game_over = game_over_scene.instance()
		add_child(game_over)
		lose = true
