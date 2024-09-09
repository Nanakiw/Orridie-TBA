extends TextureRect

signal animation_finished

var tween = null;
var disappear_time = 3.0
var is_appearing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_darkness(is_appearing)

func set_random_noise():
	material.get_shader_parameter("noise").noise.seed = randi()
	
func set_darkness(value=true):
	if value == false:
		disappear()
	else:
		appear()

func disappear(time=disappear_time):
	material.get_shader_parameter("noise").noise.seed = randi()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_method(set_shader_value, 1.0, 0.0, time).set_trans(Tween.TRANS_QUART)
	await tween.finished
	animation_finished.emit()
	var parent = get_parent()
	if is_instance_valid(parent):
		parent.remove_child(self)
	queue_free()
	
func appear(time=disappear_time):
	material.get_shader_parameter("noise").noise.seed = randi()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_method(set_shader_value, 0.0, 1.0, time).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
#	animation_finished.emit()
#	queue_free()
	
func set_shader_value(value=0.0):
	material.set_shader_parameter("line_density", value)
