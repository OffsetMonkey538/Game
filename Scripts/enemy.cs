using Godot;
using System.Collections.Generic;
using System.Linq;
using Vector2 = Godot.Vector2;

public partial class enemy : Area2D
{
	[Export] public float SeparationDistance = 20;
	[Export] public float SeparationWeight = 1;
	[Export] public float AlignmentWeight = 1;
	[Export] public float CohesionWeight = 1;
	[Export] public float TargetWeight = 1;

	private const float Speed = 195.0f;
	private const float SteerSpeed = 400.0f;
	
	public Node2D Target;

	private Vector2 _direction = Vector2.Right;

	private readonly LinkedList<enemy> _flockmates = new();
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(double delta)
	{
		Rotation = _direction.Angle();

		_direction = _calculateFlockDirection();

		Position += _direction * (float) delta;

		//Acceleration = Seek();
		//
		//Velocity += Acceleration * (float) delta;
		//Velocity = Velocity.Clamp(Vector2.Zero, new Vector2(Speed, Speed));

		//Rotation = Velocity.Angle();

		//Position += Velocity * (float) delta;




		//Vector2 desiredVelocity = Position.DirectionTo(Target.Position) * Speed * (float) delta;
		//Velocity = (desiredVelocity - Velocity).Normalized() * SteerForce;

		//Position += Velocity * (float) delta * Speed;

		//Acceleration += Seek();
		//Velocity += Acceleration * (float) delta;
		//Rotation = Velocity.Angle();
		//Position += Velocity * (float) delta;

		//Velocity = Seek();
		//Rotation = Velocity.Angle();

		//Position += Velocity * Speed * (float) delta;

		//Position += Vector2.FromAngle(RotationDegrees) * Speed * (float) delta;


		//Vector2 desiredVelocity = GetDesiredVelocity();
		//Vector2 steeringForce = GetSteeringForce(desiredVelocity);

		//Velocity += steeringForce;

		//Velocity = Velocity.Normalized();

		//Rotation = Velocity.Angle();
		//
		//Position += Velocity * Speed * (float) delta;
	}

	private Vector2 _calculateFlockDirection()
	{
		Vector2 thisGlobalPosition = GlobalPosition;
		
		Vector2 separation = Vector2.Zero;
		Vector2 heading = _direction;
		Vector2 cohesion = Vector2.Zero;
		Vector2 target = Vector2.Zero;
		
		foreach (enemy flockmate in _flockmates)
		{
			Vector2 flockmateGlobalPosition = flockmate.GlobalPosition;
			
			heading += flockmate._direction;
			cohesion += flockmateGlobalPosition;

			float distanceToFlockmate = thisGlobalPosition.DistanceTo(flockmateGlobalPosition);

			if (distanceToFlockmate < SeparationDistance)
			{
				separation -= (flockmateGlobalPosition - thisGlobalPosition).Normalized() * (SeparationDistance / distanceToFlockmate * Speed);
			}
		}
		
		// Take average
		if (_flockmates.Count > 0)
		{
			heading /= _flockmates.Count;
			cohesion /= _flockmates.Count;

			Vector2 flockCenterDirection = Position.DirectionTo(cohesion);
			float flockCenterSpeed = Speed * Position.DistanceTo(cohesion) / ((CircleShape2D) GetNode<CollisionShape2D>("DetectionRange/CollisionShape2D").Shape).Radius;
			cohesion = flockCenterDirection * flockCenterSpeed;
		}

		target = _getTargetVelocity();

		return (
			_direction +
			separation * SeparationWeight +
			heading * AlignmentWeight +
			cohesion * CohesionWeight +
			target * TargetWeight
		).Normalized() * Speed;
		//).Clamp(new Vector2(-Speed, -Speed), new Vector2(Speed, Speed));
	}

	private Vector2 _getTargetVelocity()
	{
		Vector2 desiredDirection = (Target.GlobalPosition - GlobalPosition).Normalized() * Speed;

		//desiredDirection = (desiredDirection - _direction).Normalized() * SteerSpeed;

		return desiredDirection.Normalized() * Speed;

		//Velocity += steeringForce;

		//Velocity = Velocity.Normalized();

		//Rotation = Velocity.Angle();
		//
		//Position += Velocity * Speed * (float) delta;
        
		return desiredDirection;
	}
	
	//private Vector2 GetDesiredVelocity()
	//{
	//	return (Target.GlobalPosition - GlobalPosition).Normalized() * Speed;
	//}

	//private Vector2 GetSteeringForce(Vector2 desiredVelocity)
	//{
	//	return (desiredVelocity - Velocity).Normalized() * SteerSpeed;
	//}

	private void _OnDetectionRangeEntered(Area2D area)
	{
		if (area is not enemy enemy || area == this) return;
		_flockmates.AddLast(enemy);
	}
	
	private void _OnDetectionRangeExited(Area2D area)
	{
		if (area is not enemy enemy || area == this) return;
		_flockmates.Remove(enemy);
	}
}

