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

## The current target that is closest in the area.
var _current_target: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_target_change.connect(target_changed)
	update_closest_target()


## Checks each target in the lock on area and then determines which is the closest. Emits an on_target_change signal if the target has changed.
func update_closest_target():
	while _update_targets:
		print("WAT")
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

		await(get_tree().create_timer(time_between_target_updates_in_seconds).timeout)

## Used for debug purposes only.
func target_changed(previous_target, curr_target):
	print("prev target: " + str(previous_target))
	print("curr target: " + str(curr_target))

func _exit_tree() -> void:
	_update_targets = false
