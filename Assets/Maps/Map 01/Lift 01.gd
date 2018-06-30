extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var ap = $AnimationPlayer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if ap.is_playing():
		print(ap.current_animation_position)


func _on_Trigger_body_entered(body):
	
	# check for collision with a player entering lift
	if body.name == "Player":
		if not ap.is_playing():
			ap.playback_speed = 1 # make sure we're not playing backwards still
			ap.play("Action") # play the action
		else:
			ap.playback_speed = - ap.playback_speed


func _on_Trigger_body_exited(body):
	# check for collision with a player exiting lift
	
	if body.name == "Player":
		if ap.is_playing(): # if the player exited before the Acton was finished
			ap.playback_speed = -ap.playback_speed # reverse the direction
		else:
			ap.play_backwards() # otherwise - start playback backwards
		
