data	=
{
	escalaX				: image_xscale,
	escalaY				: image_yscale,
	percent				: 0,
	amount				: 0,
	max_amount			: 0,
	filler_sprite		: spr_hp_filler,
	background_sprite	: spr_background_bar
};

xscale				= data.escalaX;
yscale				= data.escalaY;

function health_display()
{
	data.max_amount	= global.player.data.stats.max_life;
	data.amount		= global.player.data.stats.life;
	
	data.percent			= data.amount / data.max_amount;
	
	var _layer_name	= layer_get_name(self.layer);
	var _element_id	= layer_text_get_id(_layer_name, "txt_life_bar");
	

	layer_text_text(_element_id, $"{global.player.data.stats.life}/{global.player.data.stats.max_life}");	
}