if (global.paused)
{
	image_speed		= 0;
	xspd			= 0;
	yspd			= 0;
	exit;
}

image_speed			= 1;

if (global.life > 0)
{
	movement();
	scr_jump(self);
	attack();
}
else
{
	sprite_index	= spr_dead_player;
	scr_gravity_fall(self);
}
