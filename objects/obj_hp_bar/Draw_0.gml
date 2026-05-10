var background_width	= sprite_get_width(background_sprite);
var bar_width			= sprite_get_width(filler_sprite);
var current_width		= bar_width * percent;


draw_sprite_stretched(background_sprite, 0, x + 162,y + 60, background_width, 24);
draw_sprite_stretched(filler_sprite, 0, x + 162,y + 60, current_width, 24);


draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);