class_name BaseAttackComponent extends Node

## Occurs when the target has changed
signal on_target_change(previous_target, current_target)

## The Area2D that the character locks onto the closest target.
@export var lock_on_area: Area2D

## The node to compare against the targets.
@export var measurement_position: Node2D

## The time between target updates in seconds.
@export var time_between_target_updates_in_seconds: float

## Used to continue a coroutine for updating the target.
var _update_targets: bool = true

## The number of current targets.
var _num_targets: int = 0

## The current target that is closest in the area.
var _current_target: Node2D = null

## If the update target timer is running.
var _update_target_timer_running: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lock_on_area.body_entered.connect(_add_target)
	lock_on_area.body_exited.connect(_remove_target)
	on_target_change.connect(target_changed)


## Checks each target in the lock on area and then determines which is the closest. Emits an on_target_change signal if the target has changed.
func update_closest_target():
	# Run while 
	while (_update_targets || _current_target != null) && !_update_target_timer_running:
		_update_target_timer_running = true
		var closest_node: Node2D = null
		var closest_distance: float =  INF

		# Loops through all targets in the area and get the closest node.
		for current_target_to_check in lock_on_area.get_overlapping_bodies():
			var distance_from_self: float = current_target_to_check.global_position.distance_to(measurement_position.global_position)

			if distance_from_self < closest_distance:
				closest_distance = distance_from_self
				closest_node = current_target_to_check

		# Updates the current target if it is new
		if closest_node != _current_target:
			on_target_change.emit(_current_target, closest_node)
			_current_target = closest_node

		# Continue when we have waited the timeout duration
		await(get_tree().create_timer(time_between_target_updates_in_seconds, false, true, false).timeout)
		_update_target_timer_running = false

## Used for debug purposes only.
func target_changed(previous_target, curr_target):
	print("prev target: " + str(previous_target))
	print("curr target: " + str(curr_target))


## Adds a target and starts the update_closest_target coroutine.
func _add_target(_body: Node2D):
	_num_targets += 1
	if _num_targets == 1:
		_update_targets = true
		update_closest_target()

## Removes a target and updates the boolean for continuing running the coroutine.
func _remove_target(_body: Node2D):
	_num_targets -= 1
	_update_targets = _num_targets > 0
