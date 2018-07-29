extends Node2D

export var t = 0
export var ammo = 500
var lastshot = 999
var weapon = 0
var weapons = [1 , 0, 0]
var maxa = [1, 500, 50]
onready var bulletscene = preload("res://Bullet.tscn")
onready var rocketscene = preload("res://Rocket.tscn")
onready var box = preload("res://Ammobox.tscn")
onready var explosionscene = preload("res://Explosion.tscn")
onready var splashscene = preload("res://SFX/Splash.tscn")
onready var boat1 = preload("res://Boats/Boat1.tscn")
onready var boat2 = preload("res://Boats/Boat2.tscn")

func ammo():
	weapons[1] += 10
	weapons[2] += 10

func explode(pos):
	var shot = explosionscene.instance()
	shot.position = pos
	add_child(shot)
func splash(pos):
	var shot = splashscene.instance()
	shot.position = pos
	add_child(shot)
func Shoot(x, y, a, d, speed):
	var shot = bulletscene.instance()
	add_child(shot)
	shot.position.x = x
	shot.position.y = y
	shot.dir = a
	shot.speed = speed
	shot.damage = d
func missile(x, y):
	var shot = rocketscene.instance()
	add_child(shot)
	shot.position.x = x
	shot.position.y = y
	
func time():
	var mins = floor(t / 60)
	var secs = int(t) % 60
	if t > 60:
		return str(mins) + "m " + str(floor(secs)) + "s"
	else:
		return str(floor(secs)) + "s"

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
func Ammo():
	var new = box.instance()
	new.position.y = -256
	new.position.x = rand_range(-100, 100)
	add_child(new)

func _process(delta):
	if (randi() % 100 < ceil(t / 30)) || int(round(t * 5) + 3) % 180 == 0:
		AddBoat(round(rand_range(0,1)))
	if (randi() % 1000 < 1):
		Ammo()
	t += delta
	$Time.text = time()
	if weapon != 0:
		 $info.text = str(floor(weapons[weapon]))
	else:
		$info.text = ""
	$Icon.region_rect.position.x = weapon * 32
	var player = $Player
	
	if Input.is_action_just_pressed("weapon"):
		weapon = (weapon + 1) % 3
	if Input.is_action_just_pressed("prev"):
		weapon = (weapon - 1) % 3
	if weapon < 0:
		weapon = 3 + weapon
	if Input.is_action_pressed("ui_right"):
		player.position.x += 150 * delta
	if Input.is_action_pressed("ui_left"):
		player.position.x += -150 * delta
	if player.position.x < -150:
		player.position.x = 150
	if player.position.x > 150:
		player.position.x = -150
	if weapons[1] <= 0:
		weapons[1] = 0
	if weapons[1] > 500:
		weapons[1] = 500
	if weapon != 0:
		$Ammobar.min_value = 0
		$Ammobar.max_value = maxa[weapon]
		$Ammobar.value = weapons[weapon]
	if weapon != 0 && weapons[weapon] <= 0:
		weapon = 0
	if weapons[weapon] > maxa[weapon]:
		weapons[weapon] = maxa[weapon]
	if Input.is_action_pressed("shoot"):
		if weapon == 1:
			if lastshot > 0.1 && weapons[1] > 0:
				Shoot(player.position.x, player.position.y - 30,  rand_range(-0.1, 0.1), 60, 500)
				weapons[1] -= 1
				lastshot = 0
		elif weapon == 2:
			if lastshot > 0.7 && weapons[2] >= 1:
				missile(player.position.x, player.position.y - 20)
				weapons[2] -= 1
				lastshot = 0
		else:
			if lastshot > 0.4:
				Shoot(player.position.x, player.position.y - 30, 0, 300, 1000)
				lastshot = 0
			
	lastshot += delta
