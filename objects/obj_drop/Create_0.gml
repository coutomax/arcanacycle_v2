depth			= 1;

on_ground	 	= noone;
on_surface	 	= noone;

data			=
{
	move	:
	{
		xspd			: irandom_range(-2, 2),
		yspd			: irandom_range(-2, 2),
		base_y			: 0,
		min_speed		: 0.1,
		ground_y		: -999
	},
	physics :
	{
		amplitude		: 7,
		floating_time	: 0,
		float_speed		: 0.05,
		friction_		: 0.98,
	},
	visual	:
	{
		default_sprite	: noone,
	},
	flag	:
	{
		at_surface		: false,
		is_object		: true
	},
	behavior:
	{
		description		: "",
		float			: false, 
		should_move		: false, //caso algum drop ande ou se mova pela room.
		should_float	: false, //caso o objeto deva flutuar.
		default_drop	: true //for um drop sem especificidades, é aqui que ele será identificado.
	},
	stats	: {}
};

function floating_drop ()
{
	if (!data.flag.at_surface)
	{
		data.move.yspd		+= global.gravity;
		collisions(id);
	}
	else
		if (data.behavior.should_float)
		{
			if (!data.behavior.float)
			{
				if (abs(data.move.xspd) < data.move.min_speed && abs(data.move.yspd) < data.move.min_speed)
				{
					data.move.xspd		= 0;
					data.move.yspd		= 0;
					data.move.base_y	= y;
					data.behavior.float	= true;
				}
			}
			else 
			{
				data.physics.floating_time	+= data.physics.float_speed;
				y = data.move.base_y - sin(data.physics.floating_time) * data.physics.amplitude;
			}
		}
}
function height_adjustment ()
{
	if (data.flag.at_surface && data.behavior.should_float)
	{
		if (data.move.ground_y == -999)
		{
			data.move.ground_y	= y;
		}
		
		if (y >= data.move.ground_y - (sprite_height / 2))
		{
			data.move.yspd		-= global.gravity;
		}
		else
		{
			data.move.yspd		= 0;
		}
	}
}

function movement ()
{
	if (data.behavior.float)
	{
		data.move.xspd *= data.physics.friction_;
		data.move.yspd *= data.physics.friction_;
	}
	
	on_ground	 	= place_meeting(x, y + 1, obj_wall);
	on_surface	 	= place_meeting(x, y + 1, obj_platform);

	if (on_ground != noone || on_surface != noone)
	{
		data.move.xspd = 0;
	}

	x			+= data.move.xspd;
	y			+= data.move.yspd;
}