extends TextureRect
signal animation_finished

var rect_size = Vector2(1920, 1080)

func _ready():
	material.duplicate()
	adjustRect()

func adjustRect():
	material.set_shader_parameter("rel_rect_size", get_canvas_transform().get_scale()*rect_size)
		
func _process(_delta):
	adjustRect()
