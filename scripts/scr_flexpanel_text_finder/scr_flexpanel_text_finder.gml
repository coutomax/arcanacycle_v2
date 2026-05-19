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