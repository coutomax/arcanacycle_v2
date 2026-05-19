function states() constructor{
	static start	= function () {};
	static run		= function () {};
	static wait		= function () {};
	static finish	= function () {};
}

function start_state (state)
{
	actual_state	= state;
	
	actual_state.run();
}

function run_state ()
{
	actual_state.run();
}

function change_state(state)
{
	actual_state.finish();
	
	actual_state	= state;
	
	actual_state.start();
}