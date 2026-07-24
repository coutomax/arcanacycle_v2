escalaX				= image_xscale;
escalaY				= image_yscale;

xscale				= escalaX;
yscale				= escalaY;

active				= button_actions(id, actions);

active.on_create();

#region pega os dados do layout de cada botão
	getLayerName	= layer_get_name(self.layer);
	selfLayer		= layer_get_flexpanel_node(getLayerName);
	selfText		= flexpanel_text_finder(selfLayer, $"fp_{actions}");
#endregion

#region reseta o botão
function button_reset()
{
	image_index		= 0;
	
	if (selfText != undefined)
	{
		flexpanel_node_style_set_position(selfText, flexpanel_edge.top, 0, flexpanel_unit.point);
	}
}
#endregion