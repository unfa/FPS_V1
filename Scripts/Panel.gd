extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.hide() # make sure the menu is hidden when the game starts

func _process(delta):
	if Input.is_action_just_pressed("game_menu"):
		if self.visible == false:
			self.visible = true
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			self.visible = false
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
