xscale		= lerp(xscale, escalaX, 0.1);
yscale		= lerp(yscale, escalaY, 0.1);

if (actions == "reroll" && global.rerolls == 0)
{
    image_blend     = c_dkgray;
    image_alpha     = 0.65;
}

set_dimensions();