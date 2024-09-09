extends TextureRect

signal animation_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	burn()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var progress = material.get_shader_parameter("progress")
#	print(str(progress))
	if progress >= 1.99:
		animation_finished.emit()
		set_random_noise()

func set_random_noise():
	material.get_shader_parameter("noise").noise.seed = randi()

func burn():
	set_random_noise()
	var tween = create_tween()
#	var current_progress = material.get_shader_parameter("progress")
	tween.tween_method(set_shader_progress, -1.0, 2.0, 1)
	await tween.finished
	animation_finished.emit()
	
func set_shader_progress(value=0):
	material.set_shader_parameter("progress", value)
