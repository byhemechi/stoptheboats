extends Sprite

export var dir = 0
export var damage = 1000
export var speed = 250
onready var root = get_tree().get_root().get_children()[0]

func _process(delta):
	var over = []
	if $Detect.get_overlapping_areas().size() > 1:
		over = $damage.get_overlapping_areas()
	rotation = dir
	for i in over:
		if i.is_in_group("boat"):
			var ls = i.health
			i.health -= damage
			i.killedby = 1
			i.hitpos = position
			if i.health <= 0:
				root.weapons[2] += 1 / 3
				root.weapons[1] += 10
			queue_free()
	position = Vector2(position.x + (sin(dir) * speed * delta), position.y - speed * cos(dir) * delta)
	if position.y < -256:
		queue_free()
