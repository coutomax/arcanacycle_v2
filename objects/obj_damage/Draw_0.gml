if (global.player.data.stats.life > 0)
{
	draw_set_font(pixel_font);
	draw_set_colour(data.colour);

	draw_text_transformed(x, y - 10, data.text, 1.5, 1.5, 0);
}
