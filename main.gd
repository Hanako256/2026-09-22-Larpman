extends Node
var selected = 0
@export var opt_scene: PackedScene
var y_pos = 500
var x_pos
var y_in = 50
var vp_wid
var opt_arr = []
var choice
var cho_in

func _ready():
	vp_wid = get_viewport().size.x
	x_pos =  vp_wid / 2
	var opt_list = ["no", "yes", "Let's larp!"]
	spawn_options(opt_list.size())
	initialize_choices(opt_list)

#CS Club Remind: @mhscsc2627
func _process(delta):
	if (Input.is_action_just_pressed("down")):
		if (selected < opt_arr.size() - 1):
			selected += 1
		else:
			selected -= 1
	if (Input.is_action_just_pressed("up")):
		if (selected > 0):
			selected -= 1
		else:
			selected += 1
	if Input.is_action_just_pressed("select"):
		display_response(["(Shit, my larping was off again...)", "I KNEW IT! I BET YOU'RE ONE OF THOSE ITALIIAN FEMBOYS!!", "Just this once."])
	if (Input.is_anything_pressed()):
		highlight()
	
func spawn_options(num):
	var opt
	var indent = 1
	for i in range(0, num):
		opt = opt_scene.instantiate()
		add_child(opt)
		opt.position.y = y_pos + (y_in * i)
		opt.position.x = x_pos
		opt_arr.append(opt)


func initialize_choices(sbrray):
	for i in range (opt_arr.size()):
		opt_arr.get(i).set_to(sbrray.get(i))
		opt_arr.get(i).set_prior(sbrray.get(i))


func highlight():
	for i in opt_arr:
		if (opt_arr.find(i) == selected):
			i.set_color()
			choice = i
			cho_in = opt_arr.find(i)
		else:
			i.revert_color()


func display_response(response_array):
	$Text/dialogue.typewrite(response_array.get(cho_in))
