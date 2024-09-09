extends TextureRect
signal animation_finished

var tween = null

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2.ZERO
	play_animation()

func play_animation():
	set_random_noise()
	set_shader_variation()
	await get_tree().create_timer(0.01).timeout
	tween = create_tween()
	var final_value = 250.0
	tween.tween_method(set_shader_variation, 0.3, final_value, 0.9).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUINT)
	await get_tree().create_timer(0.75).timeout
	while modulate.a > 0.0:
		modulate.a -= 0.005
	await tween.finished
	animation_finished.emit()
	queue_free()
	
func set_shader_variation(value=0.3):
	material.set_shader_parameter("variation", value)

func set_random_noise():
	material.get_shader_parameter("noise_texture").noise.seed = randi()
