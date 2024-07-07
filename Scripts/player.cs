using Godot;
using System;

public partial class player : Area2D
{
	public const float Speed = 200.0f;

	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Vector2.Zero;
		
		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		Vector2 direction = Input.GetVector("move_left", "move_right", "move_up", "move_down");
		if (direction != Vector2.Zero)
		{
			velocity += direction;
		}

		if (velocity.Length() > 0)
		{
			velocity = velocity.Normalized() * Speed;
		}
		
		Position += velocity * (float) delta;
		
		// Look at mouse
		
		//TODO: This should be done through an option in the settings... whenever I make those
		//if (Input.GetConnectedJoypads().Count > 0)
		//{
			Vector2 lookInputDirection = Input.GetVector("look_left", "look_right", "look_up", "look_down");
			if (lookInputDirection != Vector2.Zero) {
				//Rotation = Mathf.Atan2(lookInputDirection.X, -lookInputDirection.Y);
				Rotation = lookInputDirection.Angle();
			}
		//}
		//else
		//{
		//	LookAt(GetGlobalMousePosition());
		//	RotationDegrees += 90;
		//}
	}
}
