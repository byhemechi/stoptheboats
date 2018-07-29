extends AnimatedSprite

var time = 0

func _process(delta):
	time += delta
	if time > 0.4:
		queue_free()