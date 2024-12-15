class_name BaseProjectileComponent extends BaseCollidableObject


var move_speed: int = 0
var target_location: Node2D
var velocity: Vector2 = Vector2.ZERO
var projectile_sfx = "basic pellet" # default value
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var basic_attack: GPUParticles2D = $BasicAttack

func init(set_starting_position: Vector2, set_damage: int, set_on_hit_effects: Array[BaseStatusEffect], set_healing: int, set_move_speed: int, set_target_or_direction, set_sfx: String) -> void:
	self.damage = set_damage
	self.status_effects = set_on_hit_effects
	self.healing = set_healing
	self.move_speed = set_move_speed
	self.projectile_sfx = set_sfx
	global_position = set_starting_position

	var direction: Vector2
	if set_target_or_direction is Node2D:
		target_location = set_target_or_direction
		direction = target_location.global_position - set_starting_position
	elif set_target_or_direction is Vector2:
		direction = set_target_or_direction

		
	velocity = (direction).normalized() * move_speed


func _physics_process(delta: float) -> void:
	position += velocity * delta

# Overwriting base to quickly fix the projectile display and sfx
func _on_body_entered(body: Node2D) -> void:
	if body.get_parent() is BaseEntity:
		var parent: BaseEntity = body.get_parent()
		_deal_damage(parent)
		_heal_health(parent)
		_apply_status_effects(parent)
	
	on_destroy.emit()
	velocity = Vector2.ZERO
	basic_attack.one_shot = true;
	set_deferred("collider.disabled", true)
	# TODO: disable the projectile's texture and hitbox
	await get_tree().create_timer(0.5).timeout # Wait for the sound effect to finish
	queue_free()
