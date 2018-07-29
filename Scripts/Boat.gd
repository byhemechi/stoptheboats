extends Area2D

export var speed = 20
export var health = 100
onready var root = get_tree().get_root().get_children()[0]
export var xspeed = 00
export var hitpos = Vector2(0, 0)
export var killedby = -1
onready var sprite = get_node("Sprite")
func _process(delta):
	position.y += speed * delta
	position.x += xspeed * delta
	if abs(position.x) > 100:
		xspeed = -xspeed
	if health <= 0:
		queue_free()
		if killedby == 1:
			root.explode(hitpos)
		root.splash(position)
	rotation += ((atan2(-xspeed, speed) + PI / 2) - rotation) / 2
	if position.y > 110:
		root.get_node("CanvasLayer/Node2D").show()
		root.get_node("CanvasLayer/Node2D/Label").text = "You lasted " + root.time()
		root.get_node("CanvasLayer/Node2D/Button").text = "Try Again"
		get_tree().paused = true