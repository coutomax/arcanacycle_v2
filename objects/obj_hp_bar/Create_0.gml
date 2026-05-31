data	=
{
	escalaX					: image_xscale,
	escalaY					: image_yscale,
	hp_percent				: 0,
	hp_amount				: 0,
	hp_max_amount			: 0,
	dash_amount				: 0,
	dash_max_amount			: global.player.data.move.dash.cooldown,
	hp_filler_sprite		: spr_hp_filler,
	hp_background_sprite	: spr_background_bar,
	dash_filler_sprite		: spr_dash_filler,
	dash_background_sprite	: spr_dash_bar_background
};

xscale					= data.escalaX;
yscale					= data.escalaY;

function health_display()
{
	data.hp_max_amount	= global.player.data.stats.max_life;
	data.hp_amount		= global.player.data.stats.life;
	data.dash_amount	= global.player.data.move.dash.cooldown;

	data.hp_percent		= data.hp_amount / data.hp_max_amount;

	var _layer_name		= layer_get_name(self.layer);
	var _element_id		= layer_text_get_id(_layer_name, "txt_life_bar");
	

	layer_text_text(_element_id, $"{global.player.data.stats.life}/{global.player.data.stats.max_life}");	
}