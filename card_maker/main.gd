extends Node2D

@onready var card_image = $card_image
@onready var card_frame = $card_frame
@onready var name_text = $name
@onready var effect_text = $effect

var list_of_cards = {
	'teleskop' = {
		'name' = 'Teleskop',
		'color' = 0,
		'effect' = 'Durchsuche das Deck nach 2 Karten, decke sie auf. Mische das Deck, lege die Karten auf das Deck.'
	},
	'recycler' = {
		'name' = 'Recycler',
		'color' = 0,
		'effect' = 'Wähle 2 Karten vom Ablagestapel. Nimm eine auf die Hand, lege die andere auf das Deck.'
	},
	'pfefferspray' = {
		'name' = 'Pfefferspray',
		'color' = 0,
		'effect' = 'Draw 2. Lege eine Karte aus deiner Hand auf das Deck.'
	},
	'trampolin' = {
		'name' = 'Tramploin',
		'color' = 1,
		'effect' = 'Lege 1 offene Karte auf das Deck.'
	},
	'blitzding' = {
		'name' = 'Blitzding',
		'color' = 1,
		'effect' = 'Mische 2 offene Karten ins Deck. Draw 1.'
	},
	'federschuhe' = {
		'name' = 'Federschuhe',
		'color' = 1,
		'effect' = 'Lege 1 Karte aus deiner Hand  unter das Deck. Lege 1 offene Karte in die Hand deines Gegners.'
	},
	'super_brille' = {
		'name' = 'Super Brille',
		'color' = 2,
		'effect' = 'Look 5. Lege sie in beliebiger Reihenfolge auf das Deck.'
	},
	'spiegel_brille' = {
		'name' = 'Spiegel Brille',
		'color' = 2,
		'effect' = 'Look 4. Lege beliebig viele davon auf das Deck oder unter das Deck. Draw 1.'
	},
	'spiral_brille' = {
		'name' = 'Spiral Brille',
		'color' = 2,
		'effect' = 'Look 3. Lege sie und eine Karte aus deiner Hand in beliebiger Reihenfolge auf das Deck.'
	},
	'doppelgänger' = {
		'name' = 'Doppelgänger',
		'color' = 3,
		'effect' = 'Draw 1. Draw 1 für jeden Doppelgänger im Ablagestapel.'
	},
	'zeitlupe' = {
		'name' = 'Zeitlupe',
		'color' = 3,
		'effect' = 'Delay 1 (Du kannst diese Karte um 1 später auslösen lassen). Draw 1 oder Mill 1.'
	},
	'glücksmünze' = {
		'name' = 'Glücksmünze',
		'color' = 3,
		'effect' = 'Rate die oberste Karte, decke sie auf und lege sie unter das Deck. Wenn du richtig lagst: Draw 2 oder dein Gegner Draw 1.'
	},
	'müllbeutel' = {
		'name' = 'Müllbeutel',
		'color' = 3,
		'effect' = 'Du kannst Mill 2. Draw 1.'
	},
	'bombe' = {
		'name' = 'Bombe',
		'color' = 4,
		'effect' = 'Wenn du am Ende des Zuges 3 oder mehr Bomben in der Hand hast, explodierst du.'
	},
}

var save_path = 'res://finished_cards/'

func _input(event):
	if event.is_action_released("save"):
		for card_name in list_of_cards.keys():
			set_card(card_name)
			await get_tree().create_timer(.05).timeout
			save_image(save_path + card_name + '.png')

func set_card(card_name):
	card_image.animation = card_name
	card_frame.frame = list_of_cards[card_name]['color']
	name_text.text = list_of_cards[card_name]['name']
	effect_text.text = list_of_cards[card_name]['effect']

func save_file(path, content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_var(content)

func save_image(file_path):
	var viewport_texture = get_viewport().get_texture()
	var image = viewport_texture.get_image()
	
	var img_width = image.get_width()
	var img_height = image.get_height()
	
	image.convert(Image.FORMAT_RGBA8)
	
#	for x in img_width:
#		for y in img_height:
#			if image.get_pixel(x, y) == Color(1, 1, 1, 1):
#				image.set_pixel(x, y, Color(1, 1, 1, 0))
#				if (x > 0 and x < img_width-1) and (y > 0 and y < img_height-1):
#					for local_x in range(-1, 2):
#						for local_y in range(-1, 2):
#							var pixel = image.get_pixel(x + local_x, y + local_y)
#							
#							if (pixel[0] == 0) and (pixel[1] == 0) and (pixel[2] == 0):
#								var alpha = pixel[3] * .75
#								image.set_pixel(x + local_x, y + local_y, Color(0, 0, 0, alpha))
	
	print(image.get_format())
	
	var error = image.save_png(file_path)
	if error != OK:
		print("Failed to save the image:", error)
	else:
		print("Image saved successfully!")

