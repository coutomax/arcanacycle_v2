if (global.paused)
{
	image_speed		= 0;
	exit;
}

image_speed			= 1;

if (global.player.data.stats.life > 0)
{
	movement();
	jump(self);
	player_attack();
}
else
{
	data.move.xspd = 0;
	sprite_index	= spr_dead_player;
	movement_apply(self);
	collisions(self);
}
