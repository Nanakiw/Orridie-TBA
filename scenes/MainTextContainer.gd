extends VBoxContainer

var rtl = preload("res://scenes/main_text_label.tscn")

var lb = "
"
var text = "Vous avancez prudemment dans le dédale obscur des Grottes de l’Ombre Écarlate, une série de tunnels sinueux connus pour engloutir ceux qui osent les explorer sans préparation. Le murmure du vent résonne à travers les parois, créant l’illusion de voix chuchotant dans une langue oubliée depuis des siècles. Votre torche éclaire faiblement les murs de pierre, révélant des gravures anciennes et des symboles mystiques que même les plus grands érudits du royaume ne pourraient déchiffrer.
Soudain, un croisement s'ouvre devant vous. Trois tunnels s’étendent dans différentes directions. Chacun semble conduire plus profondément dans les entrailles de la terre, mais vous devez choisir avec soin, car une mauvaise décision pourrait bien être votre dernière.
Si vous décidez de prendre le tunnel de gauche, dont les murs sont recouverts de lierre luminescent, allez au paragraphe 12.
Si vous choisissez le tunnel du centre, où un léger courant d’air indique une possible sortie ou un danger imminent, allez au paragraphe 25.
Si vous préférez explorer le tunnel de droite, qui est plus étroit mais semble descendre en pente douce, allez au paragraphe 37.
"
var dict_text = {}
var dict_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	separate_paragraphs()
	print(str(dict_text))
	create_paragraph()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func separate_paragraphs():
	var paragraph_text = ""
	var dict_i = 0
	for i in text.length():
		if text[i] != lb:
			paragraph_text += text[i]
		else:
			dict_text[dict_i] = paragraph_text
			dict_i += 1
			paragraph_text = ""
	
func create_paragraph():
	if dict_index < dict_text.size():
		var inst = rtl.instantiate()
		inst.final_text = dict_text[dict_index]
		add_child(inst)
		inst.connect("showed_text", create_paragraph)
		dict_index += 1
	else:
		dict_index = 0
