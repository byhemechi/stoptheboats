extends Button
onready var root = get_tree().get_root().get_children()[0]

func start():
	root.t = 0
	root.get_node("Player").position.x = 0
	for i in root.get_node("Boats").get_children():
		i.queue_free()
	get_tree().paused = false
	get_parent().hide()
	

func _ready():
	
	get_tree().paused = true
	connect("pressed", self, "start")
