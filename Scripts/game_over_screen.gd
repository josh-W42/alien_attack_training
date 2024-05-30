extends Control


func set_score(new_score: float) -> void:
	$Panel/Score.text = "Score: " + str(new_score)

func _on_button_pressed():
	pass
