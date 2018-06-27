extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#print("Pow!")
	$Sparks.emitting = true
	$Smoke.emitting = true
	$AnimationPlayer.play("Light")
	
	var sound = round(rand_range(0, 4)) 
	
	if sound == 1:
		$"Sounds/hit-01".play()
	elif sound == 2:
		$"Sounds/hit-02".play()
	elif sound == 3:
		$"Sounds/hit-03".play()
	elif sound == 4:
		$"Sounds/hit-04".play()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	#print("Deleted!")
	queue_free()
