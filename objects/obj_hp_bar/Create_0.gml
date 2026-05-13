escalaX				= image_xscale;
escalaY				= image_yscale;

xscale				= escalaX;
yscale				= escalaY;

percent				= 0;
amount				= 0;
max_amount			= 0;

filler_sprite		= spr_hp_filler;
background_sprite	= spr_background_bar

function health_display()
{
	max_amount	= global.max_life;
	amount		= global.life;
	
	percent			= amount / max_amount;
	
	var _layer_name	= layer_get_name(self.layer);
	var _element_id	= layer_text_get_id(_layer_name, "txt_life_bar");
	

	layer_text_text(_element_id, $"{global.life}/{global.max_life}");	
}