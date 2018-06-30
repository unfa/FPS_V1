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
	
	# check for collision with a player
	if body.name == "Player":
		ap.playback_speed = 1
		ap.play("Action")


func _on_Trigger_body_exited(body):
	if body.name == "Player":
		ap.playback_speed = -1
		
