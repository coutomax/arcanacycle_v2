function scr_drop_behavior(inst, description){
	if(inst != noone)
	{
		switch (description)
		{
			case "life":
				inst.should_float		= true;
			break;
		}
	}
}