extends Area2D

signal enemy_died

@export var speed = 500

func _physics_process(delta):
	global_position.x -= speed*delta

func die():
	emit_signal("enemy_died")
	destroy()

func destroy():
	queue_free()

func _on_body_entered(body):
	body.take_damage()
	destroy()
	
