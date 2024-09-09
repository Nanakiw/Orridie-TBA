extends TextureRect
signal animation_finished

var tween = null
var speed = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = Vector2.ZERO
	drain()

func drain():
	set_random_noise()
	set_shader_noise_uv()
	await get_tree().create_timer(0.2).timeout
	tween = create_tween()
	var final_value = Vector4(0.1, 1.0, speed, 0.0)
	tween.tween_method(set_shader_noise_uv, Vector4(0.1, 1.0, speed, 0.0), final_value, 0.6).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUINT)
	await tween.finished
	animation_finished.emit()
	queue_free()
#	set_shader_noise_uv(Vector4(0.1, 1.0, speed, 0.0))
#	drain()
	
func set_shader_noise_uv(value=Vector4(0.1, 1.0, speed, 0.0)):
	material.set_shader_parameter("noise_uv_scale_pan", value)

func set_random_noise():
	material.get_shader_parameter("noise_texture").noise.seed = randi()
