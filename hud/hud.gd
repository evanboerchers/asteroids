extends CanvasLayer

signal start_game

func show_message():
	$Message.show()

func show_game_over():
	show_message();
	$StartButton.show()
	
func update_score(score):
	$Score.text = "Score: %s" % str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()	
