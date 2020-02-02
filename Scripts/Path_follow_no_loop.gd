extends KinematicBody2D

var origin_pos = Vector2(self.position.x, self.position.y)

var duration = 1
var stopTime = 1
var isActivated = false

func _physics_process(delta):
	if isActivated:
		var newpos = Transform2D()
		newpos[2] = Vector2($Path2D/PathFollow2D.position + origin_pos)
		(self as KinematicBody2D).transform[2] = (self as KinematicBody2D).transform[2].linear_interpolate(newpos[2], 0.075)
	
func _ready():
	var tween = get_node("Tween")
	tween.interpolate_property($Path2D/PathFollow2D, "unit_offset",
			0, 1, duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, stopTime)
	tween.interpolate_property($Path2D/PathFollow2D, "unit_offset",
			1, 0, duration,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + stopTime*2)
	tween.start()
	tween.set_active(false)


func _on_Button_body_entered(body):
	var tween = get_node("Tween")
	isActivated = not isActivated
	if isActivated:
		tween.set_active(true)
	else:
		tween.set_active(false)
