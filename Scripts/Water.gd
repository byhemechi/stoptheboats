extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var t = 0

func _process(delta):
	t += delta
	position = Vector2((sin(t / 10) * 36), (cos(t / 5) * 20))
