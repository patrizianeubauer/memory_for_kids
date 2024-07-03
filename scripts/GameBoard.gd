extends Control

func _ready():
	print("GameBoard ready!")
	
func _on_flip_timer_timeout():
	GameManager.turnOverCards()

func _on_match_timer_timeout():
	GameManager.matchCards()

func _on_retry_btn_pressed():
	GameManager.restartGame()
