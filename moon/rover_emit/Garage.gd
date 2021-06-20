extends Sprite

export var emitting = false
export var emit_time = 3.0

var emit_timer = 0.0

var emit_angle

var emit_parent

var ARover = preload("res://moon/rover_emit/AutonomousRover.tscn")

func _ready():
	emit_angle = rotation - deg2rad(90)
	emit_parent = get_parent()
	
	if emit_parent.name.begins_with("GaragePair"):
		emit_parent = emit_parent.get_parent()

func emit_rover():
	if GS.rover != null:
		if GS.rover.is_collided:
			# Don't spawn more if there is a collision
			return
	
	var r = ARover.instance()
	r.global_position = ($EmitPoint.global_position / 32.0).round() * 32.0
	r.rotation = emit_angle
	emit_parent.add_child(r)

func _physics_process(delta):
	if not GS.run_rover:
		emit_timer = delta + 0.02
	
	if emitting:
		emit_timer -= delta
		
		if emit_timer <= 0:
			emit_timer = emit_time
			emit_rover()


func _on_Area2D_body_entered(body):
	if emitting:
		return
	
	if body.is_in_group("ARover"):
		body.queue_free()
