function jumping(object){
	
	var _space_hold			= keyboard_check(vk_space);
	var _space_pressed		= keyboard_check_pressed(vk_space);
			
	if (place_meeting(object.x, object.y + 1, [obj_wall, obj_platform, obj_slope]))
	{
		object.data.move.jump_count		= 0;
		
	}
	else
	{
		if (object.data.move.jump_count == 0)
		{
			object.data.move.jump_count	= 1;
		}
	}
			
	if (_space_pressed && object.data.move.jump_count < object.data.move.jump_max)
	{
		object.data.move.jump_count++;
		object.data.move.jump_timer		= object.data.move.jump_hold_frames;
		object.data.flag.on_ground		= false;
		object.data.flag.at_surface		= false;
	}
			
	if (!_space_hold)
	{
		object.data.move.jump_timer		= 0;
	}
			
	if (object.data.move.jump_timer > 0)
	{
		object.data.move.yspd			= object.data.move.jump_spd;
		object.data.move.jump_timer--;
	}
			
	if (object.data.move.yspd > global.max_gravity)
	{
		object.data.move.yspd			= global.max_gravity;
	}
}