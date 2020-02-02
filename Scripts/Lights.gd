extends Node2D



func _on_Button_body_entered(body):
	for x in get_children() :
		if x.get_class() == "Light":
			x.visible = not x.visible
