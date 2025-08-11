extends CanvasLayer

func show_message():
	$Message.show()
	
func show_game_start():
	$Message.hide()
	$StartButton.hide()

func show_game_over():
	show_message();
	$StartButton.show()
	
func update_score(score):
	$Score.text = "Score: %s" % str(score)

func update_lives(lives):
	$Lives.text = "Score: %s" % str(lives)

func main_menu():
	get_tree().change_scene_to_file('"res://menu/menu.tscn"')

func new_game():
	get_tree().change_scene_to_file('"res://game/game.tscn"')	
