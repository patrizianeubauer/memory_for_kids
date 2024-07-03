extends TextureButton

class_name Card

var suit
var value
var face
var back
var selectedIndex

func _ready():
	# to fit the grid automatically
	set_h_size_flags(Control.SIZE_EXPAND_FILL)
	set_v_size_flags(Control.SIZE_EXPAND_FILL)
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)
	
func _init(su, va, selectedIndex):
	print("Card initialized with suit:", su, "and value:", va)
	value = va
	suit = su
	if selectedIndex == 0:
		face = load("res://assets/karten1/" + value + "_" + suit + ".png")
	elif selectedIndex == 1:
		face = load("res://assets/karten2/" + value + "_" + suit + ".jpg")
	back = GameManager.backCard
	set_texture_normal(back)
	
func _pressed():
	GameManager.chooseCard(self)
	
func flipCard():
	if get_texture_normal() == back:
		set_texture_normal(face)
	else:
		set_texture_normal(back)
