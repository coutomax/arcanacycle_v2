if (enemy_wall)
{
	if (other.y > y)
	{
		other.y += 1;
	}
	else
	{
		other.y -= 1;
	}
	
	other.data.move.yspd = 0;
}