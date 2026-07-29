function get_ui_data(_layer = undefined, _container = undefined, _fp_name = undefined)
{
	if (_layer == undefined) return;
	if (_container == undefined) return;
	if (_fp_name == undefined) return;

	var _root 	= layer_get_name(_layer);
	var _node 	= layer_get_flexpanel_node(_root);
	var _child 	= flexpanel_node_get_child(_node, _container);
	var _text 	= flexpanel_text_finder(_child, _fp_name);

	//_teste_struct.width

	var _struct 	= flexpanel_node_get_struct(_text);
	var _element_id = _struct.layerElements[0].elementId;

	var _flexpanel_text = flexpanel_node_get_struct(_child);

	return {
        _layer: _root,
		node: _node,
		child: _child,
		text: _text,
		_struct: _struct,
		flexpanel_text: _flexpanel_text,
		element_id: _element_id
	}
}

function flexpanel_text_finder(layerName, node)
{
	var _flexpanel = flexpanel_node_get_child(layerName, node);
	
	if (_flexpanel != undefined)
	{
		var _fp_text = flexpanel_node_get_child(_flexpanel, "fp_text");
		
		if (_fp_text != undefined)
		{
			return _fp_text;
		}
		else
		{
			flexpanel_text_finder(_flexpanel, node);
		}
	}
	else
	{
		return;
	}
}

function text_scale(_element_id, _child, _text, _maximum_width, _maximum_height, _maximum_scale) {
    // 1. Seta o texto normalmente na camada de UI
    layer_text_text(_element_id, _text);
    
   	var _real_width 	= round(string_width(_text) * _maximum_scale);
	var _real_height 	= round(string_height(_text) * _maximum_scale);

    if (_real_width > _maximum_width) {
		var _new_x_scale 	= (_maximum_width / _real_width) + .3;
		var _new_y_scale 	= (_maximum_height / _real_height) + .3;

        layer_text_xscale(_element_id, _new_x_scale);
		layer_text_yscale(_element_id, _new_y_scale);

		flexpanel_node_style_set_position(_child, flexpanel_edge.top, -_new_y_scale + 2, flexpanel_unit.point);
    } else {
        layer_text_xscale(_element_id, _maximum_scale);
		layer_text_yscale(_element_id, _maximum_scale);
    }
}

function button_actions(obj, actions){
	var _a	=
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
					layer_set_visible("ui_game_over", false);
                    layer_set_visible("ui_status_bars", true);
                    global.started  = true;
					room_goto(0);
				break;		
				
				case	"settings":
					global.last_layer = obj_layer;
					layer_set_visible("ui_start_menu", false);
					layer_set_visible("ui_settings", true);
				break;	
				
				case	"exit":
					global.last_layer = obj_layer;					
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
						layer_set_visible(global.last_layer, true);
					}
				break;
				
				case "resume":
					layer_set_visible("ui_pause_menu", false);
					global.paused = false;
				break;
				
				case "main_menu":
					
					/*
						OBS: REFINAR A FUNÇÃO PARA RESETAR O JOGO
					*/

					layer_set_visible("ui_start_menu", true);
					layer_set_visible("ui_pause_menu", false);
					layer_set_visible("ui_game_over", false);
					layer_set_visible("ui_status_bars", false);
					game_reset();
					room_goto(1);
				break;
            
                case "reroll":
                    if (global.rerolls > 0)
                    {
                        global.roll_cards = true;
                    }
                break;
            
                case "skip":
                    
                break; 
				case "pt":
                    global.language = 0;
					layer_set_visible(obj_layer, false);
					layer_set_visible(global.last_layer, true);
                break;
				case "en":
                    global.language = 1;
					layer_set_visible(obj_layer, false);
					layer_set_visible(global.last_layer, true);
                break;  
			}
		}
	}
	
	return _a;
}

