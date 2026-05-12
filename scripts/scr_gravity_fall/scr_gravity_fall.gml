function scr_gravity_fall(obj){
//aplica a gravidade no yspd
	obj.yspd				+= global.gravity;
	
	var _v_collision = move_and_collide(0, obj.yspd, obj_wall, abs(obj.yspd)+1 , obj.xspd, obj.yspd, obj.xspd, obj.yspd)
	
	if (array_length(_v_collision)  > 0)
	{
	    obj.yspd			= 0;
		
		if (variable_instance_exists(obj, "is_a_part"))
		{
			if (obj.is_a_part)
			{
				obj.xspd	= 0;
			}
		}
	}
}