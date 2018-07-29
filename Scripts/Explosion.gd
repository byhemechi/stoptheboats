extends Particles2D

var time = 0

func _process(delta):
	time += delta
	if time > 3:
		queue_free()