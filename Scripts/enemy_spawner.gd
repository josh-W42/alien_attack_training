extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawn(path_enemy_instance)

@onready var timer_node = $SpawnTImer
@onready var spawn_positions = $SpawnPositions
@onready var timer_path_node = $SpawnPathTimer

var enemy_scene = preload("res://Scenes/enemy_1.tscn")
var path_enemy_scene = preload("res://Scenes/path_enemy.tscn")

func _ready():
	timer_node.connect("timeout", on_timeout)
	timer_path_node.connect("timeout", spawn_enemy_on_path)
	
func spawn_enemy_on_path():
	var path_enemy = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawn", path_enemy)
	
	
	
func on_timeout():
	spawn_enemy()

func spawn_enemy():
	var positions_array = spawn_positions.get_children()
	var random_position_child = positions_array.pick_random()
	var random_postion = random_position_child.global_position
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_postion
	emit_signal("enemy_spawned", enemy_instance)
