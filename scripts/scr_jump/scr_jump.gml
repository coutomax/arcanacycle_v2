/*
*
*								Configuração do pulo
*
*/	
function scr_jump(object){
	
	var _space_hold			= keyboard_check( vk_space );
	var _space_pressed		= keyboard_check_pressed( vk_space );
			
	if (place_meeting(object.x, object.y + 1, obj_wall) || place_meeting(object.x, object.y + 1, obj_platform))
			{
				object.jump_count		= 0;
			}
			else
			{
				if (object.jump_count == 0)
				{
					object.jump_count	= 1;
				}
			}
			
			if (_space_pressed && object.jump_count < object.jump_max)
			{
				object.jump_count++;
				object.jump_timer		= object.jump_hold_frames;
				object.at_ground		= false;
			}
			
			if (!_space_hold)
			{
				object.jump_timer		= 0;
			}
			
			if (object.jump_timer > 0)
			{
				object.yspd				= object.jump_spd;
				object.jump_timer--;
			}
			
			if (object.yspd > global.max_gravity)
			{
				object.yspd				= global.max_gravity;
			}
}