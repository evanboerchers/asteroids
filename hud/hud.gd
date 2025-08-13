extends CanvasLayer
	
func show_game_start():
	$GameOver.hide()
	$FinalScore.hide()
	$Buttons.hide()
	$Info.show()


func show_game_over(score):
	$FinalScore.text = "Score: %d" % score
	$Info.hide()
	$Buttons.show()
	$GameOver.show()
	$FinalScore.show()
	
func update_score(score):
	$Info/Score.text = "Score: %d" % score

func update_lives(lives):
	$Info/Lives.text = "Lives: %d" % lives

func main_menu():
	get_tree().change_scene_to_file("res://menu/menu.tscn")

func new_game():
	get_tree().change_scene_to_file("res://game/game.tscn")	
