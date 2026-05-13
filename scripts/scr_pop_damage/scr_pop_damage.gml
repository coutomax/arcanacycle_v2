function scr_pop_damage(inst, target){
	if (target != noone)
	{
		if (target.alive)
		{
			var _dmg		= instance_create_layer(target.x, target.y, "Instances", obj_damage);
		
			_dmg.colour	= c_red;
			_dmg.text	= string(inst.damage);
		}
	}
}