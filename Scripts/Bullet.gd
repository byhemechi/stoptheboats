extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _process(delta):
	var over = get_overlapping_areas()
	for i in over:
		queue_free()
		i.queue_free()
	position = Vector2(position.x, position.y - 500 * delta)
	if position.y < -256:
		queue_free()
