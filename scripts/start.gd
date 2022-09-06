extends Node


# Declare member variables here. Examples:
var dict_leaderboard = {}
var list_leaderboard = []
var new_rankers_and_score = []
var current
var f = File.new()
var string = ""
var rankers_and_scores
var curr_name
var curr_score

# Called when the node enters the scene tree for the first time.
func _ready():
	# reading the file
	f.open("res://leaderboard.txt", File.READ)
	rankers_and_scores = f.get_line().split(",")
	sort_score(rankers_and_scores)
	f.close()

class CustomSort:
	static func sort_name_ascending(a, b):
		if a[0] < b[0]:
			return true
		return false
	static func sort_score_descending(a, b):
		if a[1] > b[1]:
			return true
		return false
		
func sort_score(leaderboard):
	# sorting it based on score in the main menu in case changes were made off game
	# if only this was in python T_T
	
	# taking out the repeated values using dict
	for x in leaderboard:
		current = x.split(":")
		curr_name = current[0].to_upper()
		curr_score = current[1]
		
		if !curr_name in dict_leaderboard:
			dict_leaderboard[curr_name] = curr_score
		else:
			if curr_score > dict_leaderboard[curr_name]:
				dict_leaderboard[curr_name] = curr_score
	
	# turning dict to list for later use
	for y in dict_leaderboard:
		list_leaderboard.append([y, int(dict_leaderboard[y])])
	
	# sorting the list for real
	list_leaderboard.sort_custom(CustomSort, "sort_name_ascending")
	list_leaderboard.sort_custom(CustomSort, "sort_score_descending")
	new_rankers_and_score = list_leaderboard
	
	while len(new_rankers_and_score) > 10:
		new_rankers_and_score.pop_back()
	
	f.open("res://leaderboard.txt", File.WRITE)
	string = ""
	for a in new_rankers_and_score:
		string += str(a[0]) + ":" + str(a[1]) + ","
	string.erase(string.length() - 1, 1)
	f.store_string(string)
	f.close()
  

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
