extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Trigger_body_entered(body):
	
	# check for collision with a player
	if body.name == "Player":
		#print ("Player detected!")
		$AnimationPlayer.play("Action")


func _on_Trigger_body_exited(body):
	if body.name == "Player":
		#print ("Player detected!")
		$AnimationPlayer.play_backwards("Action")
		
