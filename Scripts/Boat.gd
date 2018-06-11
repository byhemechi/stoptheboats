extends Area2D

export var speed = 20
onready var root = get_tree().get_root().get_children()[0]
export var xspeed = 00
onready var sprite = get_node("Sprite")
func _process(delta):
	position.y += speed * delta
	position.x += xspeed * delta
	if abs(position.x) > 100:
		xspeed = -xspeed
	rotation += ((atan2(-xspeed, speed) + PI / 2) - rotation) / 2
	if position.y > 110:
		root.get_node("CanvasLayer/Node2D").show()
		root.get_node("CanvasLayer/Node2D/Label").text = "You lasted " + str(floor(root.t)) + "s"
		root.get_node("CanvasLayer/Node2D/Button").text = "Try Again"
		get_tree().paused = true