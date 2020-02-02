extends Area2D

export (String, FILE, "*.tscn") var tele_to


func _on_Tele_to_B_body_entered(body):
	if body.name == "Player":
		Global_vars.tele_to_letter = 'B'
		get_tree().change_scene(tele_to)

