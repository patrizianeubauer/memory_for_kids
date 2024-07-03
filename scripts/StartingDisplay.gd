extends Control

@onready var playBtn
@onready var selectBox
var pic
var text
var selectedIndex

func _ready():
	playBtn = get_node('ColorRect/CenterContainer/Panel/playBtn')
	selectBox = get_node('ColorRect/VBoxContainer/HBoxContainer/themeOption')
	selectBox.add_item("Number 1-10")
	selectBox.add_item("Animals")

func _on_play_btn_pressed():
	print("New game pressed")
	GameManager.restartGame()
	queue_free()

func win():
	pic = get_node('ColorRect/CenterContainer/Panel/VBoxContainer/TextureRect')
	pic.set_texture(load("res://assets/ui-items/completed.png"))
	
	text = get_node('ColorRect/CenterContainer/Panel/playLabel')
	text.text = "Won in "+ str(GameManager.moves) +" moves!"

func _on_theme_option_item_selected(index):
	GameManager.setThemeWithIndex(index)
