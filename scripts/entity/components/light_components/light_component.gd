class_name LightComponent extends PointLight2D
## A PointLight2D which allows adjustments based on initial values.

## The initial light brightness.
var initial_light_energy: float

## The initial light size.
var initial_light_size: float

## The current percent of the initial value to use for light brightness.
var current_light_energy_percent: float = 1.0

## The current percent of the initial value to use for light size.
var current_light_size_percent: float = 1.0

func _ready() -> void:
    initial_light_energy = energy
    initial_light_size = texture_scale

## Used to change the percent scaling of the light brightness and then update the light brightness.
func change_light_energy_by_percent(percent_to_change: float) -> void:
    current_light_energy_percent += percent_to_change
    # change the brightness to use the percent but do not allow lower than 0%
    current_light_energy_percent = max(0, current_light_energy_percent)
    energy = initial_light_energy * current_light_energy_percent

## Used to change the percent scaling of the light size and then update the light size.
func change_light_size_by_percent(percent_to_change: float) -> void:
    current_light_size_percent += percent_to_change
    # change the size to use the percent but do not allow lower than 0%
    current_light_size_percent = max(0, current_light_size_percent)
    texture_scale = initial_light_size * current_light_size_percent
