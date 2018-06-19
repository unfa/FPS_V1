extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("game_menu"):
		if self.visible == false:
			self.visible = true
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		else:
			self.visible = false
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
