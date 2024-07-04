using Godot;
using System;

public partial class EnemySpawner : Node2D
{
	[Export] public PackedScene Enemy;
	[Export] public Node2D Target;
	[Export] public Node Level;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		// TODO: Remove, for debugging
		if (Input.IsActionJustPressed("ui_select"))
		{
			SpawnEnemies(6, 300);
		}
	}

	public void SpawnEnemies(int amount, float radius)
	{
		float radiansPerEnemy = 2*Mathf.Pi / amount;
			
		for (int i = 0; i < amount; i++)
		{
			Node2D enemy = Enemy.Instantiate<Node2D>();

			enemy.Position = GlobalPosition + Vector2.Up.Rotated(i * radiansPerEnemy) * radius;
			enemy.Set("Target", Target);
				
			Level.AddChild(enemy);
		}
	}
}
