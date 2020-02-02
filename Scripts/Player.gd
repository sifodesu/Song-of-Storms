extends KinematicBody2D
 
export var GRAVITY_SPEED = 1200
export var  WALK_SPEED = 40000
export var JUMP_SPEED = 80000
export var fall_multiplier = 2.5
export var low_jump_multiplier = 2

export var in_air_resistance_x = 0.5
export var MAX_NUMBER_OF_JUMPS = 2

var velocity = Vector2(0, 0)
var last_x_dir = 0
var jump_tokens = 0

var previous_x_pos = 0

func _physics_process(delta):
	var direction_x = 0
	var left_pressed = false
	var right_pressed = false
	
	if Input.is_action_pressed("ui_left"):
		left_pressed = true
	if Input.is_action_pressed("ui_right"):
		right_pressed = true
	
	if left_pressed and right_pressed:
		direction_x = -last_x_dir
	else:
		if left_pressed:
			last_x_dir = -1
		elif right_pressed:
			last_x_dir = 1
		else:
			last_x_dir = 0
		direction_x = last_x_dir
	
	var isOnFloor = is_on_floor()
	velocity.x = WALK_SPEED*direction_x*delta
	
	if !isOnFloor:
		if velocity.y <= 0:
			velocity.y += GRAVITY_SPEED*low_jump_multiplier*delta
		if velocity.y > 0:
			velocity.y += GRAVITY_SPEED*fall_multiplier*delta
		
	else :
		velocity.y = 0
		if !Input.is_action_pressed("ui_up"):
			jump_tokens = MAX_NUMBER_OF_JUMPS
		
	if Input.is_action_just_pressed("ui_up"):
		if jump_tokens > 0:
			velocity.y = -JUMP_SPEED*delta
			jump_tokens -= 1
				
				
# warning-ignore:return_value_discarded
	#move_and_slide(Vector2(0,0), Vector2(0, 1))
	
	#if(is_on_floor()):
	#	if(velocity.y <= 0):
	#		velocity.y = 0	
# warning-ignore:return_value_discarded
	var snap = Vector2.DOWN * 32 if jump_tokens == MAX_NUMBER_OF_JUMPS else Vector2.ZERO
	move_and_slide_with_snap(velocity, snap, Vector2(0, -1))
	#previous_x_pos =

#get_tree().change_scene
