class_name BaseAttackComponent extends Node

signal on_target_change(previous_target, current_target)

## The Area2D that the character locks onto the closest target.
@export var lock_on_area: Area2D

## The node to compare against the targets.
@export var measurement_position: Node2D


## The current target that is closest in the area.
var _current_target: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_target_change.connect(target_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	update_closest_target()


## Checks each target in the lock on area and then determines which is the closest. Emits an on_target_change signal if the target has changed.
func update_closest_target():
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

## Used for debug purposes only.
func target_changed(previous_target, curr_target):
	print("prev target: " + str(previous_target))
	print("curr target: " + str(curr_target))
