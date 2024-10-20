class_name BaseProjectileComponent extends Area2D

var damage: int = 20  # Damage inflicted by the projectile
var healing: int = 0
var move_speed: int = 100
var on_hit_effects: Array[int] = [] # Integer for now, change to status_effect once implemented
var target_location: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _init(set_damage: int = 20, set_on_hit_effects: Array = [], set_healing: int = 0, set_move_speed: int = 100, set_target_location: Vector2 = Vector2.ZERO) -> void:
    self.damage = set_damage
    self.on_hit_effects = set_on_hit_effects
    self.healing = set_healing
    self.move_speed = set_move_speed
    self.target_location = set_target_location

func _ready() -> void:
    # Connect the area_entered signal
    area_entered.connect(_deal_damage)

    velocity = (Vector2.RIGHT) * move_speed # We only shooting right

func _deal_damage(area: Area2D) -> void:
    if area.has_method("take_damage"):
        area.take_damage(damage)
        # Apply any on-hit effects
        # for effect in on_hit_effects:
        #     if area.has_method("add_status_effect"):
        #         area.apply_status_effect(effect)
    queue_free()


func _physics_process(delta: float) -> void:
    position += velocity * delta
