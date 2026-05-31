var _hp_background_width	= sprite_get_width(data.hp_background_sprite);
var _hp_bar_width			= sprite_get_width(data.hp_filler_sprite);
var _hp_current_width		= _hp_bar_width * data.hp_percent;

var _dash_background_width	= sprite_get_width(data.dash_background_sprite);
var _dash_bar_width			= sprite_get_width(data.dash_filler_sprite);
var _dash_current_width		= _dash_bar_width * (data.dash_amount / data.dash_max_amount);

draw_sprite_stretched(data.hp_background_sprite, 0, x + 162,y + 60, _hp_background_width, 24);
draw_sprite_stretched(data.hp_filler_sprite, 0, x + 162,y + 60, _hp_current_width, 24);

draw_sprite_stretched(data.dash_background_sprite, 0, x + 288,y + 138, _dash_background_width, 24);
draw_sprite_stretched(data.dash_filler_sprite, 0, x + 288,y + 138, _dash_current_width, 24);

draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);