extends Node


# Declare member variables here. Examples:
var f = File.new()
var string = ""
var rankers_and_scores
var list_leaderboard = []
var curr_name
var curr_score
var rankers
var current
var dict_leaderboard = {}
var new_rankers_and_score = []
var name_only = []
onready var names_node = get_node("leaderboard_name_show")
onready var scores_node = get_node("leaderboard_score_show")

# Called when the node enters the scene tree for the first time.
func _ready():
	f.open("res://leaderboard.txt", File.READ)
	rankers_and_scores = f.get_line().split(",")
	
	list_leaderboard = []
	for x in rankers_and_scores:
		current = x.split(":")
		list_leaderboard.append([current[0], int(current[1])])
	
	list_leaderboard.sort_custom(CustomSort, "sort_name_ascending")
	list_leaderboard.sort_custom(CustomSort, "sort_score_descending")
	new_rankers_and_score = list_leaderboard
	f.close()
	leaderboard_show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

class CustomSort:
	static func sort_name_ascending(a, b):
		if a[0] < b[0]:
			return true
		return false
	static func sort_score_descending(a, b):
		if a[1] > b[1]:
			return true
		return false


func leaderboard_show():
	var f = File.new()
	f.open("res://leaderboard.txt", File.READ)
	names_node.set_text("")
	scores_node.set_text("")
	rankers = f.get_line().split(",")
	for x in rankers:
		current = x.split(":")
		names_node.set_text(names_node.get_text() + "\n" + str(current[0]))
		scores_node.set_text(scores_node.get_text() + "\n" + str(current[1]))
	f.close()


func append_score(name, score):
	f.open("res://leaderboard.txt", File.READ)
	rankers_and_scores = f.get_line().split(",")
	
	list_leaderboard = []
	for x in rankers_and_scores:
		current = x.split(":")
		list_leaderboard.append([current[0], int(current[1])])
		name_only.append(current[0])
	
	if name in name_only:
		if score > int(list_leaderboard[name_only.find(name, 0)][1]):
			list_leaderboard[name_only.find(name, 0)] = [name, score]
	else:
		list_leaderboard.append([name, score])
		
	list_leaderboard.sort_custom(CustomSort, "sort_name_ascending")
	list_leaderboard.sort_custom(CustomSort, "sort_score_descending")
	new_rankers_and_score = list_leaderboard
	
	while len(new_rankers_and_score) > 10:
		new_rankers_and_score.pop_back()
	
	f.open("res://leaderboard.txt", File.WRITE)
	for a in new_rankers_and_score:
		string += str(a[0]) + ":" + str(a[1]) + ","
	string.erase(string.length() - 1, 1)
	f.store_string(string)
	f.close()
	
	leaderboard_show()
