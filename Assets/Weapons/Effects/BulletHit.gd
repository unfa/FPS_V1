extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#print("Pow!")
	$Sparks.emitting = true
	$Smoke.emitting = true
	$AnimationPlayer.play("Light")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	#print("Deleted!")
	queue_free()
