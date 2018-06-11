extends Node2D

export var t = 0

onready var bulletscene = preload("res://Bullet.tscn")
onready var boat1 = preload("res://Boats/Boat1.tscn")
onready var boat2 = preload("res://Boats/Boat2.tscn")

func Shoot(x, y):
	var shot = bulletscene.instance()
	add_child(shot)
	shot.position.x = x
	shot.position.y = y

func AddBoat(type):
	var new
	if type == 1:
		new = boat1.instance()
	else:
		new = boat2.instance()
	new.position.y = -256
	new.speed = rand_range(20 + t,50 + t)
	new.xspeed = rand_range(-100, 100)
	new.position.x = rand_range(-100, 100)
	$Boats.add_child(new)

func _process(delta):
	if randi() % 100 < 1:
		AddBoat(round(rand_range(0,1)))
	t += delta

	var player = $Player
	if Input.is_action_pressed("ui_right"):
		player.position.x += 150 * delta
	if Input.is_action_pressed("ui_left"):
		player.position.x += -150 * delta
	if Input.is_action_just_pressed("shoot"):
		Shoot(player.position.x, player.position.y - 30)
