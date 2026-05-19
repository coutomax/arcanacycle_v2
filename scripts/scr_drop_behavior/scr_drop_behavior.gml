function drop_behavior(inst, description){
	if(inst != noone)
	{
		switch (description)
		{
			case "life":
				inst.data.behavior.should_float		= true;
			break;
		}
	}
}