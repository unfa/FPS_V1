extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var health = 25 # how much health will be restored on pickup?
export var respawn = false # should this pickup respawn?
export var respawn_time = 3 # how many seconds to wait before respawning

var active = true # is the health pack active?

var SpinSpeed = 1.25 # set the speed of the spinning animation

func _ready():
	$AnimationPlayer.play("Float") # start the floating animation
	$RespawnTimer.wait_time = respawn_time

func _process(delta):
	$MeshInstance.rotate_y(SpinSpeed * delta) # spinning animation


func _on_Area_body_entered(body):
	if body.has_method('heal') and active: # if body that collided is healable and this health pack is active
		if body.heal(health): # try healing the body. If that succeds (returns true) do everhything that is required to remove this health pack
			$PickupSound.play() # play the pickup sound
			self.hide() # hide the node so it seems to have disappeare immediately
			active = false # make it inactive so no more heath will be give to whoever tries to pick it up next
			
			if respawn: # if this pickup should respawn
				$RespawnTimer.start()
			else:
				$DeleteTimer.start() # start the timer that will wait for the sound to finish playback and then delete the scene


func _on_Timer_timeout():
	self.queue_free() # delete the scene

func _on_RespawnTimer_timeout():
	self.show()
	active = true
	$RespawnSound.play()
	$RespawnTimer.stop()
