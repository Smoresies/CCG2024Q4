class_name BaseProjectileComponent extends Area2D

var damage: int = 20 # Damage inflicted by the projectile
var healing: int = 0
var move_speed: int = 0
var on_hit_effects: Array[int] = [] # Integer for now, change to status_effect once implemented
var target_location: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func init(set_starting_position: Vector2, set_damage: int, set_on_hit_effects: Array[int], set_healing: int, set_move_speed: int, set_target_location: Vector2) -> void:
	self.damage = set_damage
	self.on_hit_effects = set_on_hit_effects
	self.healing = set_healing
	self.move_speed = set_move_speed
	self.target_location = set_target_location
	global_position = set_starting_position
	velocity = set_target_location * move_speed # We only shooting right

func _ready() -> void:
	# Connect the area_entered signal
	body_entered.connect(_heal_health)
	body_entered.connect(_deal_damage)
	

func _deal_damage(body: Node2D) -> void:
	var parent: BaseEntity = body.get_parent()
	var parent_health_component: BaseHealthAndStatusComponent = parent.health_and_status_component
	parent_health_component.take_damage(damage)
	# Apply any on-hit effects
	# for effect in on_hit_effects:
	#     if area.has_method("add_status_effect"):
	#         area.apply_status_effect(effect)
	queue_free()

func _heal_health(body: Node2D) -> void:
	var parent: BaseEntity = body.get_parent()
	var parent_health_component: BaseHealthAndStatusComponent = parent.health_and_status_component
	parent_health_component.heal_health(healing)


func _physics_process(delta: float) -> void:
	position += velocity * delta
