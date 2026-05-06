function scr_button_actions(obj, actions){
	var a	=
	{
		
		object			: obj,
		action			: actions,
		obj_layer		: noone,
		
		on_create		:	function ()
		{
			obj_layer	= layer_get_name(self.object.layer);
		},
		
		on_activate		:	function ()
		{
			switch (action)
			{
				case	"new_game":
					layer_set_visible("ui_start_menu", false);
					room_goto(0);
					global.in_game		= true;
				break;		
				
				case	"settings":
		
				break;	
				
				case	"exit":
					
					if (obj_layer != noone)
					{
						layer_set_visible(obj_layer, false);
						layer_set_visible("ui_yes_no_menu_option", true);
					}
				break;
				
				case	"yes_option":
					game_end();
				break;
				
				case	"no_option":
					if (obj_layer != noone)
					{
						layer_set_visible(obj_layer, false);
						layer_set_visible("ui_start_menu", true);
					}
				break;
				
				case "resume":
					layer_set_visible("ui_pause_menu", false);
					global.paused = false;
				break;
			}
		}
	}
	
	return a;
}

