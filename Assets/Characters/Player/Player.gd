extends KinematicBody

var movement = Vector3()
export var walk_speed = 350
export var run_speed = 750
export var jump_velocity = 500
export var gravity_acceleration = 1400
export var terminal_velocity = 2500
export var air_control = 0.025
export var ground_control = 0.5
var current_control = ground_control

var walking = false
var on_ground = false

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$AnimationPlayer.play("BreatheBob")
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	#print(Input.get_last_mouse_speed())
	
	if Input.is_action_just_pressed("control_flashlight"):
		if $LeftHand/Flashlight.visible:
			$LeftHand/Flashlight.hide()
		else:
			$LeftHand/Flashlight.show()
	
	pass

func _physics_process(delta):
	
	# are the player's feet touching the ground?
	if $GroundArea.colliding <= 0:
		on_ground = false
	else:
		on_ground = true
		
	if on_ground:
		current_control = ground_control
	else:
		current_control = air_control
	
	# deafutl to not walking
	walking = false
	
	# front/back walking
	if Input.is_action_pressed("move_forward"):
		movement.z = lerp(movement.z, -walk_speed, current_control)
		walking = true
	elif Input.is_action_pressed("move_backward"):
		movement.z = lerp(movement.z, walk_speed, current_control)
		walking = true
	else:
		movement.z = lerp(movement.z, 0, current_control)
		
	
	
	#left/right strafing
	if Input.is_action_pressed("move_left"):
		movement.x = lerp(movement.x, -walk_speed, current_control)
		walking = true
	elif Input.is_action_pressed("move_right"):
		movement.x = lerp(movement.x, walk_speed, current_control)
		walking = true
	else:
		movement.x = lerp(movement.x, 0, current_control)

	
	# gravity acceleration
	if not on_ground:
		movement.y -= gravity_acceleration * delta
		walking = false
	
	# jump
	if on_ground and Input.is_action_just_pressed("move_jump"):
		movement.y = jump_velocity
	
	# make sure we don't cross terminal velocity when falling
	if movement.y < -terminal_velocity:
		movement.y = -terminal_velocity
		
	# execute the movement vector
	self.move_and_slide(movement*delta)
	
	# animations
	
	#play view bobbin animation

	
		
	#if walking:
	#	$AnimationPlayer.play("WalkBob")
	#else:
	#	$AnimationPlayer.play("BreatheBob")
		
	#print($AnimationPlayer.is_playing())
	
