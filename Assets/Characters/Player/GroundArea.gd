extends Area

export var colliding = -1

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


func _on_GroundArea_body_entered(body):
	colliding += 1
	#print (colliding)


func _on_GroundArea_body_exited(body):
	colliding -= 1
	#print (colliding)
