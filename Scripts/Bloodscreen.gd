extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var health = 100
var previous_health = health

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	health = $"../../Actors/Player".health
	
	if health <= 0 and previous_health > 0:
		$"../AnimationPlayer".play("Bloodscreen")
	
	previous_health = health
