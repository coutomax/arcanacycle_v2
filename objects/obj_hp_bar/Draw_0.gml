var _background_width	= sprite_get_width(data.background_sprite);
var _bar_width			= sprite_get_width(data.filler_sprite);
var _current_width		= _bar_width * data.percent;


draw_sprite_stretched(data.background_sprite, 0, x + 162,y + 60, _background_width, 24);
draw_sprite_stretched(data.filler_sprite, 0, x + 162,y + 60, _current_width, 24);


draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);