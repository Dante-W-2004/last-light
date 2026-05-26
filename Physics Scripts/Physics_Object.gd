extends CharacterBody2D
class_name PhysicsObject

signal linear_velocity_changed(new_velocity: Vector2)
signal angular_velocity_changed(new_velocity: float)

@export var mass: float = 1.0

@export var center_of_mass: Vector2 = Vector2.ZERO
@export var physics_shape: PhysicsShape

var TOTAL_FORCE: Vector2 = Vector2.ZERO
var total_force: Vector2:
	get: return TOTAL_FORCE
	set(force): return
	
var TOTAL_TORQUE: float = 0
var total_torque: float:
	get: return TOTAL_TORQUE
	set(torque): return

var unscaled_linear_velocity: Vector2 = Vector2.ZERO
var angular_velocity: float = 0

func add_force(force: Vector2, application_point: Vector2 = center_of_mass) -> void:
	self.TOTAL_FORCE += force
	
	var delta_application: Vector2 = application_point - center_of_mass
	var torque: float = delta_application.x * force.y - delta_application.y * force.x
	
	self.TOTAL_TORQUE += torque
	
func add_torque(torque: float) -> void:
	self.TOTAL_TORQUE += torque

func calculate_linear_acceleration() -> Vector2:
	return self.total_force / self.mass
	
func apply_linear_acceleration(acceleration: Vector2, delta: float) -> void:
	self.unscaled_linear_velocity = self.velocity * GlobalPhysics.meters_per_pixel
	
	self.unscaled_linear_velocity += acceleration * delta
	
	if self.unscaled_linear_velocity.length() < 1e-3:
		self.unscaled_linear_velocity = Vector2.ZERO
	
	linear_velocity_changed.emit(unscaled_linear_velocity)
	self.velocity = unscaled_linear_velocity / GlobalPhysics.meters_per_pixel
	
	self.TOTAL_FORCE = Vector2.ZERO
	
func calculate_angular_acceleration() -> float:
	return self.total_torque / physics_shape.calculate_inertia(self.mass)
	
func apply_angular_acceleration(acceleration: float, delta: float) -> void:
	self.angular_velocity += acceleration * delta
	
	if abs(self.angular_velocity) < 1e-3:
		self.angular_velocity = 0
	
	angular_velocity_changed.emit(self.angular_velocity)
	self.rotation += angular_velocity * delta
	
	self.TOTAL_TORQUE = 0

func apply_forces(delta: float) -> void:
	apply_linear_acceleration(calculate_linear_acceleration(), delta)
	apply_angular_acceleration(calculate_angular_acceleration(), delta)

	move_and_slide()
