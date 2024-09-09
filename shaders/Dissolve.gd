extends TextureRect

signal animation_finished

var tween = null;
var disappear_time = 1.8
var is_dissolving = true
var sped_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	dissolve(is_dissolving)
	
func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		if tween:
			tween.kill()
			disappear_time = 0.25
			dissolve(is_dissolving)

func set_random_noise():
	material.get_shader_parameter("noise").noise.seed = randi()
	
func dissolve(value=true):
	if value == true:
		disappear()
	else:
		appear()

func disappear(time=disappear_time):
	var current_dissolve_value = material.get_shader_parameter("dissolve_value")
	if current_dissolve_value == 0.0:
		material.get_shader_parameter("dissolve_texture").noise.seed = randi()
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_method(set_shader_value, current_dissolve_value, 1.0, time).set_trans(Tween.TRANS_SINE)
	await tween.finished
	animation_finished.emit()
#	queue_free()
	
func appear(time=disappear_time):
	var current_dissolve_value = material.get_shader_parameter("dissolve_value")
	if current_dissolve_value == 1.0:
		material.get_shader_parameter("dissolve_texture").noise.seed = randi()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_method(set_shader_value, current_dissolve_value, 0.0, time).set_trans(Tween.TRANS_SINE)
	await tween.finished
	animation_finished.emit()
#	queue_free()
	
func set_shader_value(value=0):
	material.set_shader_parameter("dissolve_value", value)
