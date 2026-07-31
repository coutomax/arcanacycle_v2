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
					_swap_layer(action, obj_layer, "ui_status_bars", ["ui_start_menu", "ui_game_over"], function () {
						global.started  = true;
						room_goto(0);
					})
				break;		
				
				case	"settings":
					_swap_layer(action, obj_layer, "ui_settings", ["ui_start_menu", "ui_pause_menu"]);
				break;	
				
				case	"exit":
					_swap_layer(action, obj_layer, "ui_yes_no_menu_option", ["ui_start_menu", "ui_pause_menu"]);
				break;
				
				case	"yes_option":
					var _next_layer	= global.last_action == "skip" ? undefined : "ui_start_menu";

					_swap_layer(action, obj_layer, _next_layer, ["ui_yes_no_menu_option", "ui_pause_menu"], function () {
						if (global.last_action == "exit")
						{
							game_end();
						}

						if (global.last_action == "main_menu")
						{
							game_reset();
							room_goto(1);
						}

						if (global.last_action == "skip")
						{
							global.paused = false;
						}
					});					
				break;
				
				case	"no_option":
					_swap_layer(action, obj_layer, global.last_layer, ["ui_yes_no_menu_option"]);
				break;
				
				case "resume":
					_swap_layer(action, obj_layer, "ui_pause_menu", ["ui_pause_menu"], function () {
						global.paused = false;
					});
				break;
				
				case "main_menu":
					_swap_layer(action, obj_layer, "ui_yes_no_menu_option", ["ui_pause_menu", "ui_game_over", "ui_status_bars"]);
				break;
            
                case "reroll":
                    if (global.rerolls > 0)
                    {
                        global.roll_cards = true;
                    }
                break;
            
                case "skip":
					_swap_layer(action, obj_layer, "ui_yes_no_menu_option");
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

function _swap_layer(_commit_action = undefined, _actual_layer = undefined, _next_layer = undefined, _close_layers = [], _execute = undefined)
{
	if (_actual_layer == undefined) return;

	if (array_length(_close_layers) > 0)
	{
		for (var i = 0; i < array_length(_close_layers); i++)
		{
			layer_set_visible(_close_layers[i], false);
		}
	}

	if (_execute != undefined && is_callable(_execute))
	{
		_execute();
	}

	if (_next_layer != undefined)
	{
		layer_set_visible(_next_layer, true);
	}

	layer_set_visible(_actual_layer, false);
	
	/*
	if (global.last_action == _actual_action || global.last_action == noone)
	
	*/

	global.last_action 	= _commit_action;
	global.last_layer 	= _actual_layer;
}

