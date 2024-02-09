extends CanvasLayer

signal start_game

func show_message(text_):
	$Message.text = text_ 
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("GAME OVER")
	await $MessageTimer.timeout
	
	$Message.text = "EVITEZ LES ENNEMIS!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score_):
	$ScoreLabel.text = str(score_)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()
