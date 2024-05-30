extends CharacterBody2D

signal took_damage

var speed = 500

# On way to avoid always loading a sceen when we want to instantiate it is todo
# The differenece between the load vs preload functions is that both load a file but
# preload only loads the file once and creates a reference to that loaded file.
var rocket_scene = preload("res://Scenes/rocket.tscn")

# There's another way to do this as well
#var rocket_container_node: Node
#
#func _ready():
	#rocket_container_node = get_node("RocketContainer")
	
# And then there's another shorthand of getting a node by useing '$'
#@onready var rocket_container_node = get_node("RocketContainer")
@onready var rocket_container_node = $RocketContainer

@onready var fire_rocket_sound = $FireRocketSound

func _process(delta):
	if (Input.is_action_just_pressed("shoot")):
		shoot()
	
	
func shoot():
	fire_rocket_sound.play()
	var rocket_instance = rocket_scene.instantiate()
	# commented out because we needed rockets to be added to a container rather than the player.
	# This is because we want a rocket's position to be independant of the player when fired.
	#add_child(rocket_instance)
	rocket_container_node.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if (Input.is_action_pressed("fly_right")):
		velocity.x = speed
	elif (Input.is_action_pressed("fly_down")):
		velocity.y = speed
	elif (Input.is_action_pressed("fly_left")):
		velocity.x = -speed
	elif (Input.is_action_pressed("fly_up")):
		velocity.y = -speed
	move_and_slide()

	var window_size = get_window().size
	# One way to clamp the player to the window
	#if (global_position.x < 0):
		#global_position.x = 0
	#elif (global_position.x > window_size.x):
		#global_position.x = window_size.x
	#elif (global_position.y < 0):
		#global_position.y = 0
	#elif (global_position.y > window_size.y):
		#global_position.y = window_size.y
	
	# Another way to clamp the player
	#global_position.x = clampf(global_position.x, 0, window_size.x)
	#global_position.y = clampf(global_position.y, 0, window_size.y)
	
	# Another way to clamp the player (in our opinion the best way)
	global_position = global_position.clamp(Vector2(0,0), window_size)
	
func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
