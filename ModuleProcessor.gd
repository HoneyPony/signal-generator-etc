extends Node2D

func reset_visited():
	for module in get_tree().get_nodes_in_group("Modules"):
		module.visited_this_frame = false
		
func get_input_modules(module):
	var jack_ins = module.get_inputs()
	
	var result = []
	
	for jack in jack_ins:
		var j = jack.jack_coupling
		if j == null:
			continue
		
		j = j.paired_jack
		if j == null:
			continue
			
		j = j.plug_coupling
		if j == null:
			continue
			
		# at this point we have gotten the plug
		if j.is_input:
			# if the input is wired to an input, it doesn't count
			continue
			
		result.append(j.get_parent())
		
	return result
		
func process_module(module, delta):
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

func _process(delta):
	reset_visited()
	
	for module in get_tree().get_nodes_in_group("Modules"):
		process_module(module, delta)
