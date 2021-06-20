extends Node2D

func reset_visited():
	for module in get_tree().get_nodes_in_group("Modules"):
		module.visited_this_frame = false
		
func get_input_modules(module):
	var jack_ins = module.get_inputs()
	
	var result = []
	
	for jack in jack_ins:
		if not is_instance_valid(jack):
			continue
		
		var j = jack.jack_coupling
		if not is_instance_valid(j) or j == null:
			continue
		
		j = j.paired_jack
		if not is_instance_valid(j) or j == null:
			continue
			
		j = j.plug_coupling
		if not is_instance_valid(j) or j == null:
			continue
			
		# at this point we have gotten the plug
		if j.is_input:
			# if the input is wired to an input, it doesn't count
			continue
			
		result.append(j.get_parent())
		
	return result
		
func process_module(module, delta):
	if module.visited_this_frame:
		return
	
	# no matter what, this module is now visited. as such, if there is a
	# loop, it will terminate at some point.
	# if there is no loop, the evaluation logic will eventually work out to the
	# correct order.
	module.visited_this_frame = true
	
	var inputs = get_input_modules(module)
	# Make sure all inputs are up-to-date (or part of a circular chain...)
	for input in inputs:
		if not input.visited_this_frame:
			process_module(input, delta)
			
	# at this point, all inputs are up-to-date.
	module.mod_process(delta)

func _physics_process(delta):
	GS.rover_m_left_p = 0.0
	GS.rover_m_left_r = 0.0
	GS.rover_m_right_p = 0.0
	GS.rover_m_right_r = 0.0
	
	for i in range(0, 4):
		GS.antenna_out[i] = 0.0
	
	#print("START PROCESS")
	reset_visited()
	
	for module in get_tree().get_nodes_in_group("Modules"):
		process_module(module, delta)
