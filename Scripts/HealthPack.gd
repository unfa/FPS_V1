extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var health = 25

var SpinSpeed = 1.25

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$AnimationPlayer.play("Float")

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	
	$MeshInstance.rotate_y(SpinSpeed * delta)


func _on_Area_body_entered(body):
	if body.has_method('heal'):
		if body.heal(health):
			self.queue_free()
