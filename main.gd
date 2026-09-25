extends Node
var selected = 0
@export var opt_scene: PackedScene
var y_pos = 500
var x_pos
var y_in = 50
var vp_wid
var opt_arr = []
var choice
var cho_in = 0
var prompt_list
var opt_time = false
var prompt_index
var prompt_i = 0
var prompt_bools
var opt_mat
var opt_i = 0
var opt_mat_sub = []
var response_array = []

func _ready():
	vp_wid = get_viewport().size.x
	x_pos =  vp_wid / 2
	prompt_list = ["Woah, I see a new season of this anime, KKJa, has dropped recently.", "I've never watched it, but I lowkey wanna join the hype, so I'll join the online forum discussion"]
	prompt_bools = [1, 0, 1]
	opt_mat = [["no", "yes", "Let's larp!"], ["no", "yes"]]
	response_array = [["(Shit, my larping was off again...)", "I KNEW IT! I BET YOU'RE ONE OF THOSE ITALIIAN FEMBOYS!!", "Just this once."], ["YOU THOUGHT YOUR FIRST KISS WOULD BE JOJO, BUT IT WAS I, JOHNNY!", "Oh...uh..."]]
	opt_mat_sub = opt_mat.get(opt_i)
	advance_prompt()
	highlight()


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
	
	if (!opt_time):
		if (Input.is_action_just_pressed("select")):
			advance_prompt()
	else:
		if Input.is_action_just_pressed("select"):
			display_response(response_array.get(opt_i))
	if (Input.is_anything_pressed()):
		highlight()


func highlight():
	for i in opt_arr:
		if (opt_arr.find(i) == selected):
			i.set_color()
			choice = i
			cho_in = opt_arr.find(i)
		else:
			i.revert_color()


func spawn_options(num):
	var opt
	for i in range(0, num):
		opt = opt_scene.instantiate()
		add_child(opt)
		opt.position.y = y_pos + (y_in * i)
		opt.position.x = x_pos
		opt_arr.append(opt)

func initialize_choices(sbrray):
	print (sbrray)
	for i in range (opt_arr.size()):
		opt_arr.get(i).set_to(sbrray.get(i))
		opt_arr.get(i).set_prior(sbrray.get(i))

func new_option_set(list):
	spawn_options(list.size())
	initialize_choices(list)
	opt_time = true

func display_response(response_arr):
	if (cho_in < response_arr.size()):
		$Text/dialogue.typewrite(response_arr.get(cho_in))
	for i in opt_arr:
		remove_child(i)
	opt_arr.clear()
	opt_time = false
	opt_i += 1

func advance_prompt():
	if (prompt_i < prompt_list.size()):
		$Text/dialogue.typewrite(prompt_list.get(prompt_i))
		if (prompt_bools.get(prompt_i) == 1):
			opt_mat_sub = opt_mat[opt_i]
			new_option_set(opt_mat_sub)
		prompt_i += 1
