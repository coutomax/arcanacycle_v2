image_alpha = 1;

fade_timer  = 30;

fader       = function ()
{
    if (fade_timer > 0)
    {
        fade_timer  -= 1;
        image_alpha = fade_timer / 30;
    }

    if (fade_timer <= 0 || image_alpha <= 0)
    {
        instance_destroy(id);
    }
}