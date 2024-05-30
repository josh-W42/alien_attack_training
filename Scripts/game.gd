extends Node2D

var lives = 3
var score = 0

@onready var player = $Player
@onready var hud: Control = $UI/HUD
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

var game_over_scene: Resource = preload("res://Scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_deadzone_area_entered(area):
	area.destroy()
	
func _on_player_took_damage():
	lives -= 1
	hud.set_score_label(score)
	hud.set_lives_label(lives)
	player_hit_sound.play()
	if (lives <= 0):
		player.die()
		var game_over_ui: Control = game_over_scene.instantiate()
		game_over_ui.set_score(score)
		$UI.add_child(game_over_ui)


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("enemy_died", enemy_hit)
	add_child(enemy_instance)
	
func enemy_hit():
	enemy_hit_sound.play()
	increase_score(100)

func increase_score(amount: float):
	score += amount
	hud.set_score_label(score)


func _on_enemy_spawner_path_enemy_spawn(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("enemy_died", enemy_hit)
