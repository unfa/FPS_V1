extends KinematicBody

var movement = Vector3()

export var health = 100
var previous_health = health
export var walk_speed = 350
export var run_speed = 750
export var jump_velocity = 500
export var gravity_acceleration = 1400
#export var terminal_velocity = 2500
export var air_control = 0.025
export var ground_control = 0.5

export var mouselook_speed = 400
export var mouselook_pitch_limit = PI / 2

var current_control = ground_control

var walking = false
var on_ground = true

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$AnimationPlayer.play("Breathe")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if health > 0:
		# mouselook
		if event is InputEventMouseMotion:
			rotate_y(event.relative[0] / - mouselook_speed )
			$Camera.rotate_x(event.relative[1] / - mouselook_speed )
			if $Camera.rotation[0] < - mouselook_pitch_limit:
				$Camera.rotation[0] = -mouselook_pitch_limit
			
			if $Camera.rotation[0] > mouselook_pitch_limit:
				$Camera.rotation[0] = mouselook_pitch_limit

func _process(delta):
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	#print(Input.get_last_mouse_speed())
	if health > 0:
		# toggle flashlight
		if Input.is_action_just_pressed("control_flashlight"):
			if $Camera/LeftHand/Flashlight.visible:
				$Camera/LeftHand/Flashlight.hide()
			else:
				$Camera/LeftHand/Flashlight.show()
	elif previous_health > 0: #if the player is dead, but was alive last time this function was called...
		$AnimationPlayer.stop() # stop the breathing animation
		$AnimationPlayer.play("Die") # alnd play they dying animation
	
	previous_health = health
		

func _physics_process(delta):
	
	# are the player's feet touching the ground?
	
	
	if $Feet.is_colliding():
		on_ground = true
	else:
		on_ground = false
		
	if on_ground:
		current_control = ground_control
	else:
		current_control = air_control
	
	# deafutl to not walking
	walking = false
	
	# front/back walking
	if health > 0: #if we're alive:
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
		
		# jump
		if on_ground and Input.is_action_just_pressed("move_jump"):
			movement.y = jump_velocity
			$Sounds/Jump.play()
			$AnimationPlayer.play("Jump")
			
	else: #if we're dead
		# player should stop walking
		movement.z = lerp(movement.z, 0, current_control)
		movement.x = lerp(movement.x, 0, current_control)
		
	
	# gravity acceleration
	if not on_ground:
		movement.y -= gravity_acceleration * delta
		walking = false
	
	
	
	# make sure we don't cross terminal velocity when falling
	#if movement.y < -terminal_velocity:
	#	movement.y = -terminal_velocity
		
		
	# apply the movement vector
	#print(movement)
	
	self.move_and_slide((to_global(movement) - translation ) * delta)
	
	# camera movement animations:
	
	#if walking:
	#	$AnimationPlayer.play("WalkBob")
	#else:
	#	$AnimationPlayer.play("BreatheBob")
		
	#print($AnimationPlayer.is_playing())
	