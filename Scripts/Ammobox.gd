extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var health = 1

func _process(delta):
	position.y += 100 * delta
	scale.x += (health - scale.x) / 10
	scale.y += (health - scale.y) / 10
	if position.y > 256:
		queue_free()