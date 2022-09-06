extends Node


# Declare member variables here. Examples:
onready var names_node = get_node("leaderboard_name_show")
onready var scores_node = get_node("leaderboard_score_show")
var rankers
var current
var list_leaderboard = []
var string = ""
var f = File.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	leaderboard_show()
	

class CustomSort:
	static func sort_name_ascending(a, b):
		if a[0] < b[0]:
			return true
		return false
	static func sort_name_descending(a, b):
		if a[0] > b[0]:
			return true
		return false
	static func sort_score_ascending(a, b):
		if a[1] < b[1]:
			return true
		return false
	static func sort_score_descending(a, b):
		if a[1] > b[1]:
			return true
		return false
		

func leaderboard_show():
	f.open("res://leaderboard.txt", File.READ)
	names_node.set_text("")
	scores_node.set_text("")
	rankers = f.get_line().split(",")
	for x in rankers:
		current = x.split(":")
		names_node.set_text(names_node.get_text() + "\n" + str(current[0]))
		scores_node.set_text(scores_node.get_text() + "\n" + str(current[1]))
	f.close()
	
func sort_name(toggle):
	f.open("res://leaderboard.txt", File.READ)
	rankers = f.get_line().split(",")
	
	list_leaderboard = []
	for x in rankers:
		list_leaderboard.append([x.split(":")[0], int(x.split(":")[1])])
	
	if toggle == false:
		list_leaderboard.sort_custom(CustomSort, "sort_name_descending")
	else:
		list_leaderboard.sort_custom(CustomSort, "sort_name_ascending")
	f.close()
	
	f.open("res://leaderboard.txt", File.WRITE)
	string = ""
	for a in list_leaderboard:
		string += str(a[0]) + ":" + str(a[1]) + ","
	string.erase(string.length() - 1, 1)
	f.store_string(string)
	f.close()
	
	leaderboard_show()
	
func sort_score(toggle):
	f.open("res://leaderboard.txt", File.READ)
	rankers = f.get_line().split(",")
	
	list_leaderboard = []
	for x in rankers:
		list_leaderboard.append([x.split(":")[0], int(x.split(":")[1])])
	
	if toggle == false:
		list_leaderboard.sort_custom(CustomSort, "sort_name_ascending")
		list_leaderboard.sort_custom(CustomSort, "sort_score_descending")
	else:
		list_leaderboard.sort_custom(CustomSort, "sort_name_ascending")
		list_leaderboard.sort_custom(CustomSort, "sort_score_ascending")
	f.close()
	
	f.open("res://leaderboard.txt", File.WRITE)
	string = ""
	for a in list_leaderboard:
		string += str(a[0]) + ":" + str(a[1]) + ","
	string.erase(string.length() - 1, 1)
	f.store_string(string)
	f.close()
	
	leaderboard_show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
