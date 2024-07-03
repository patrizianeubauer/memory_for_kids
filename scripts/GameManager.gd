extends Node

@onready var GameBoard = get_node('/root/GameBoard/')
@onready var InfoDisplay = GameBoard.get_node('InfoDisplay')

var backCard = preload("res://assets/karten1/cardback.png")
var deck = Array()
var card1
var card2
var pairs = 0
var pairsLabel
var moves = 0
var movesLabel
var goalOfGame = 10
var selectedIndex = 0

var startDisplay = preload('res://scenes/StartingDisplay.tscn')

func _ready():
	fillDeck()
	setupInfoDisplay()
	var startPopUp = startDisplay.instantiate()
	GameBoard.add_child(startPopUp)
	
func fillDeck():
	var card
	var kartenwerte
	var kartensymbole
	
	if(selectedIndex == 0):
		kartenwerte = ["eins", "zwei", "drei", "vier", "fuenf", "sechs", "sieben", "acht", "neun", "zehn"]
	elif selectedIndex == 1:
		kartenwerte = ["esel", "eule", "ziege", "fuchs", "hase", "kuh", "loewe", "pferd", "schaf", "zebra"]
	
	kartensymbole = ["punkt", "zahl"]
	
	var shuffled_cards = []
	
	# Erstellen einer Liste der möglichen Kombis
	for symbol in kartensymbole:
		for wert in kartenwerte:
			shuffled_cards.append([symbol, wert])
	
	# Mischen
	shuffled_cards.shuffle()

	# Hinzufügen der Karten in zufälliger Reihenfolge zum Grid
	for shuffled_card in shuffled_cards:
		var symbol = shuffled_card[0]
		var wert = shuffled_card[1]
		card = Card.new(symbol, wert, selectedIndex)
		GameBoard.get_node('grid').add_child(card)

func chooseCard(c):
	if card1 == null:
		card1 = c
		card1.flipCard()
		card1.set_disabled(true)
	elif card2 == null:
		card2 = c 
		card2.flipCard()
		card2.set_disabled(true)
		checkCards()
		
func checkCards():
	if card1.value == card2.value:
		GameBoard.get_node('MatchTimer').start()
	else:
		GameBoard.get_node('FlipTimer').start()
	
	moves += 1
	movesLabel.text = str(moves)

func turnOverCards():
	card1.flipCard()
	card2.flipCard()
	card1.set_disabled(false)
	card2.set_disabled(false)
	card1 = null
	card2 = null

func matchCards():
	pairs += 1
	pairsLabel.text = str(pairs)
	
	# remove card from deck
	card1.set_modulate(Color(1,1,1,0))
	card2.set_modulate(Color(1,1,1,0))
	card1 = null
	card2 = null
	
	if pairs == goalOfGame:
		var endScreen = startDisplay.instantiate()
		GameBoard.add_child(endScreen)
		endScreen.win()

func setupInfoDisplay():
	movesLabel = InfoDisplay.get_node("Panel/Parts/VBoxContainer/moves")
	pairsLabel = InfoDisplay.get_node("Panel/Parts/VBoxContainer2/pairs")
	
	if movesLabel:
		movesLabel.text = str(moves)
	else:
		print("Error: 'moves' node not found!")
		
	if pairsLabel:
		pairsLabel.text = str(pairs)
	else:
		print("Error: 'pairs' node not found!")

func restartGame():
	print("restart game")
	var grid = GameBoard.get_node('grid')
	
	for card in range(deck.size()):
		deck[card].queue_free()
	
	if grid:
		for child in grid.get_children():
			grid.remove_child(child)
			child.queue_free()
	else:
		print("Error: 'grid' node not found!")
			
	deck.clear()
	fillDeck()
	pairs = 0
	moves = 0
	setupInfoDisplay()

func setThemeWithIndex(index):
	selectedIndex = index
