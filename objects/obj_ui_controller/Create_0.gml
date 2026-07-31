active_layer    = "undefined";
title           = get_tittle_id(global.active_layer);

set_title_translation   = function ()
{
    if (global.active_layer == undefined) return;
    if (!variable_struct_exists(global.dialogue_struct, global.active_layer)) return;
    if (!variable_struct_exists(global.dialogue_struct[$ global.active_layer], "menu_title")) return;

    var _struct 	= flexpanel_node_get_struct(title);
	var _element_id = _struct.layerElements[0].elementId;

    var _translated_title   = global.dialogue_struct[$ global.active_layer].menu_title;
    var _element_text_id    = layer_text_get_id(global.active_layer, $"{global.active_layer}_title");

    layer_text_text(_element_text_id, _translated_title);
    #region REDIMENSIONAMENTO 
        var _max_width   = _struct.width;
        var _max_height  = _struct.height;

        var _real_width  = round(string_width(_translated_title) * _struct.layerElements[0].textScaleX);
        var _real_height = round(string_height(_translated_title) * _struct.layerElements[0].textScaleY);

        if (_real_width > _max_width || _real_height > _max_height)
        {
            var _new_x_scale 	= (_max_width / _real_width) + .5;
            var _new_y_scale 	= (_max_height / _real_height) + .5;

            layer_text_xscale(_element_id, _new_x_scale);
		    layer_text_yscale(_element_id, _new_y_scale);
        }

      
    #endregion
}