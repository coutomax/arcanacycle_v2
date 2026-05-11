if (global.paused)
{
	exit;
}

if (global.life < 0)
{
	obj_hp_bar.sprite_index		= spr_broken_hp_bar;
	global.life					= 0;
}