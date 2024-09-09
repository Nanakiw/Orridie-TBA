extends RichTextLabel

signal showed_text

## The speed at which the text animation will play
@export var playback_speed = 1.5
## The speead at which each character will appear
@export var normal_delay = 0.05
## The long stop delay
@export var long_stop_delay = 0.8
## The long stop characters
@export var long_stop_chars = [".", "?", "!"]
## The short stop delay
@export var short_stop_delay = 0.35
## The short stop characters
@export var short_stop_chars = [",", ";", ":"]
const BB_CODE_FX: Dictionary = {
	"fade1" : "[fade start=-10" + " length=10]",
	"fade2" : "[/fade]"
}

var ready_to_fade_out: bool = false
var fade_duration: float = 1.0
var fade_tween: Tween

var raw_text = "Vous perdez 1 PV. Votre ennemi se transforme en chaise et vous frappe !
Vous buvez un bon café et regagnez 150 PV.
Vous etes à court d'energie !
Il est temps d'aller, se reposer...
Hohohoooo !!!
Heheeeeee !
Vous perdez 1 PV.
Votre ennemi se transforme en chaise, et vous frappe !
Vous buvez un bon café et regagnez 150 PV.
Vous etes à court d'energie !
Il est temps d'aller se reposer...
Hohohoooo !!!
Heheeeeee !Vous perdez 1 PV.
Votre ennemi se transforme en chaise, et vous frappe !
Vous buvez un bon café, et regagnez 150 PV.
Vous etes à court d'energie !
Il est temps d'aller se reposer...
Hohohoooo !!!
Heheeeeee !
Vous perdez 1 PV.
Votre ennemi se transforme en chaise, et vous frappe !
Vous buvez un bon café, et regagnez 150 PV.
Vous etes à court d'energie !
Il est temps d'aller se reposer...
Hohohoooo !!!
Heheeeeee !
Vous perdez 1 PV.
Votre ennemi se transforme en chaise, et vous frappe !
Vous buvez un bon café et regagnez 150 PV.
Vous etes à court, d'energie !
Il est temps d'aller se reposer...
Hohohoooo !!!
Heheeeeee !"

var final_text = ""

## Called when the node enters the scene tree for the first time.
func _ready():
	text = ""
	visible_ratio = 0
	read_text()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		visible_ratio = 1.0
		
func format_text(txt):
	pass

func read_text():
	for i in final_text.length():
		var current_text = ""
		var current_char = final_text[i]
		var last_char = null
		var next_char = null
		if i < final_text.length() - 1:
			next_char = final_text[i+1]
		if i > 0:
			last_char = final_text[i-1]
		var delay = normal_delay
		if last_char != null and (current_char in long_stop_chars) == false:
			if last_char in short_stop_chars:
				delay = short_stop_delay
				print("short")
			elif last_char in long_stop_chars:
				delay = long_stop_delay
				print("long")
		await get_tree().create_timer(delay).timeout
		current_text += final_text[i]
		print(str(current_text))
		if visible_ratio < 1.0:
			visible_characters += 1.0
			text = "[fade start=" + str(i-10) + " length=10]" + final_text + "[/fade]"
		if visible_ratio >= 1.0:
			text = final_text
			emit_signal("showed_text")
			return
			
#var counter = -20
#
#func _physics_process(_delta):
#	if is_playing_text_animation == true:
#		counter += 1
#	if counter < 161:
#		text = "[fade start=" + str(counter) + " length=10]" + final_text + "[/fade]"
