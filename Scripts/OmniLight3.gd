tool
extends OmniLight

# flickering light

var energy = self.light_energy
export var flicker = 0.25

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	#print(energy)
	self.light_energy = rand_range(energy * (1 - flicker), energy)
