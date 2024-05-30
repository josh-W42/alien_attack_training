extends Control

@onready var score = $Score
@onready var lives = $Lives

func set_score_label(new_score: float) -> void:
	score.text = "SCORE: " + str(new_score)

func set_lives_label(amount: float) -> void:
	lives.text = "X " + str(amount)
	
