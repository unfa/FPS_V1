extends Spatial

export var ready = true
export var hit_force = 20

onready var hitFXscene = load("res://Assets/Weapons/Effects/BulletHit.tscn")

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

func shoot():
	if ready:
		# play the shooting animation
		$AnimationPlayer.play("Shoot")
		#$Sounds/Shoot.stop()
		$Sounds/Shoot.play()
		
		# cast a ray to see if we hit anything
		$ProjectileSpawner/RayCast.enabled = true
		
		# see what we hit
		var hit_object = $ProjectileSpawner/RayCast.get_collider()
		var hit_point = $ProjectileSpawner/RayCast.get_collision_point()
		var hit_normal = $ProjectileSpawner/RayCast.get_collision_normal()
		
		#print(hit_object)
		#print(hit_point)
		#print(hit_normal)
		
		# stop here if we hit nothing
		if hit_object == null:
			return
		
		# apply for to all rigid bodies
		if hit_object is RigidBody:
			hit_object.apply_impulse(hit_point, - (hit_normal * hit_force))
			
		# emit particles if we hit something
		var hitFX = hitFXscene.instance()
		hitFX.translate(hit_point)
		get_tree().root.add_child(hitFX)