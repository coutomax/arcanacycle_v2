function setup (_config)
{
	data = variable_clone(_config);
}

function default_enemy ()
{
	return 
	{
		life: 25,
        damage: 5,
        experience: 5,

        xspd: 0,
        yspd: 0,

        pursue: true,

        alive: true
	}
}