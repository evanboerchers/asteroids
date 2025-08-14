extends CanvasLayer
	
func show_game_start():
	$GameOver.hide()
	$FinalScore.hide()
	$Buttons.hide()
	$Info.show()

func show_game_over():
	$Info.hide()
	$Buttons.show()
	$GameOver.show()
	$FinalScore.show()

func main_menu():
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func new_game():
	get_tree().change_scene_to_file("res://game/game.tscn")	

func _process(_delta: float) -> void:
		$Info/Lives.text = "Lives: %d" % Global.lives
		$Info/Score.text = "Score: %d" % Global.score
		$FinalScore.text = "Score: %d" % Global.score
