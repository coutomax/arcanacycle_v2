function scr_pop_damage(inst, target){
	if (target != noone)
	{
		if (target.alive)
		{
			var dmg		= instance_create_layer(target.x, target.y, "Instances", obj_damage);
		
			dmg.colour	= c_red;
			dmg.text	= string(inst.damage);
		}
	}
}