if (global.life > 0)
{
	draw_set_font(pixel_font);
	draw_set_colour(colour);

	draw_text_transformed(x, y - 10, text, 1.5, 1.5, 0);
}
