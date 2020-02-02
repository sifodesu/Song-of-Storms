extends Node2D

func get_class():
	return "Light"

func _on_Button_body_entered(body):
	$Pink.visible = false
