extends CanvasLayer
	
func show_game_start():
	$Message.hide()
	$Buttons.hide()

func show_game_over():
	$Message.show()
	$Buttons.hide()
	
func update_score(score):
	$Info/Score.text = "Score: %d" % score

func update_lives(lives):
	$Info/Lives.text = "Lives: %d" % lives

func main_menu():
	get_tree().change_scene_to_file('"res://menu/menu.tscn"')

func new_game():
	get_tree().change_scene_to_file('"res://game/game.tscn"')	
