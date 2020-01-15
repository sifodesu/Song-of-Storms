extends KinematicBody2D

export var GRAVITY_SPEED = 25
export var  WALK_SPEED = 250
export var JUMP_SPEED = 500

export var MAX_NUMBER_OF_JUMPS = 2

var velocity = Vector2(0, 0)
var last_x_dir = 0
var jump_tokens = 0

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
	
	velocity.x = WALK_SPEED*direction_x
	
	#move_and_slide(Vector2(0,0), Vector2(0, -1))	#force is_on_floor to be reevaluated now
	var isOnFloor = is_on_floor()
	
	
	#
	
	if !isOnFloor:
		velocity.y += GRAVITY_SPEED
		
	else :
		velocity.y = 0
			
		if !Input.is_action_pressed("ui_up"):
			jump_tokens = MAX_NUMBER_OF_JUMPS
		
	if Input.is_action_just_pressed("ui_up"):
		if jump_tokens > 0:
			velocity.y = -JUMP_SPEED
			jump_tokens -= 1
				
				
	move_and_slide(velocity, Vector2(0, -1))
