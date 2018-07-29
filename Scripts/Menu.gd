extends Button
onready var root = get_tree().get_root().get_children()[0]

func start():
	root.t = 0
	root.get_node("Player").position.x = 0
	for i in root.get_node("Boats").get_children():
		i.queue_free()
	root.weapons[1] = 0
	root.weapons[2] = 0
	get_tree().paused = false
	get_parent().hide()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && get_tree().paused:
		start()

func _ready():
	get_tree().paused = true
	connect("pressed", self, "start")
