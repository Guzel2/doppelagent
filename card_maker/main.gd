extends Node2D

@onready var card_image = $card_image
@onready var card_frame = $card_frame
@onready var name_text = $name
@onready var effect_text = $effect

var list_of_cards = {
	'blitzding' = {
		'name' = 'Blitzding',
		'color' = 1,
		'effect' = 'Mische 2 offene Karten ins Deck. Draw 1.'
	},
	'bombe' = {
		'name' = 'Bombe',
		'color' = 4,
		'effect' = 'Wenn du am Ende des Zuges 3 oder mehr Bomben in der Hand hast, explodierst du.'
	},
	'doppelgänger' = {
		'name' = 'Doppelgänger',
		'color' = 3,
		'effect' = 'Draw 1. Draw 1 für jeden Doppelgänger im Ablagestapel.'
	},
}

func _ready():
	set_card('bombe')

func set_card(card_name):
	card_image.animation = card_name
	card_frame.frame = list_of_cards[card_name]['color']
	name_text.text = list_of_cards[card_name]['name']
	effect_text.text = list_of_cards[card_name]['effect']

func save_img():
	pass
