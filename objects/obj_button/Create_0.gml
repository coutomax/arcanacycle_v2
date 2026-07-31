escalaX     = image_xscale;
escalaY     = image_yscale;

xscale      = escalaX;
yscale      = escalaY;

active      = button_actions(id, actions);
ui_data     = get_ui_data(self.layer, "fp_buttons", $"fp_{actions}");

active.on_create();

language            = undefined;

#region pega os dados do layout de cada botão
	getLayerName	= layer_get_name(self.layer);
	selfLayer		= layer_get_flexpanel_node(getLayerName);
	selfText		= flexpanel_text_finder(selfLayer, $"fp_{actions}");
#endregion

layer_data  = get_layer_data(self.layer, actions);

function button_reset()
{
	image_index		= 0;
	
	if (layer_data.text != undefined)
	{
		flexpanel_node_style_set_position(layer_data.text, flexpanel_edge.top, 0, flexpanel_unit.point);
	}
}

set_dimensions = function ()
{
    if (!variable_struct_exists(global.dialogue_struct, ui_data._layer)) return;
        
    var _panel_struct	= ui_data._struct;
    var _max_scale 		= _panel_struct.layerElements[0].textScaleX;  
    var _real_width 	= round(string_width(global.dialogue_struct[$ ui_data._layer][$ actions]) * _max_scale);
    
    if (variable_struct_exists(ui_data.flexpanel_text.nodes[0].nodes[0], "width"))
    {
    	var _width	= ui_data.flexpanel_text.nodes[0].nodes[0].width;
    	var _height	= ui_data.flexpanel_text.nodes[0].nodes[0].height;
    }
    else
    {
    	var _width	= 0;
    	var _height	= 0;
    }
    
    var _max_width 		= _width == 0 ? 80 : _width;
    var _max_height		= _height == 0 ? 40 : _height;
    
    text_scale(ui_data.element_id, ui_data.text, global.dialogue_struct[$ ui_data._layer][$ actions], _max_width, _max_height, _max_scale);
}