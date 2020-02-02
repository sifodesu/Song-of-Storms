extends Node2D


func _ready():
	if Global_vars.tele_to_letter != "X":
		var pathToTiti = "./Tele_here_" + str(Global_vars.tele_to_letter)
		$Player.position = get_node(pathToTiti).position
