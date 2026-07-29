function get_layer_data(_layer, _fp_name){
    
	get_layer_name    = layer_get_name(_layer);
	node              = layer_get_flexpanel_node(get_layer_name);
	text	          = flexpanel_text_finder(node, $"fp_{_fp_name}");
    
    return {
        layer_name  : get_layer_name,
        node        : node,
        text        : text 
    }
}