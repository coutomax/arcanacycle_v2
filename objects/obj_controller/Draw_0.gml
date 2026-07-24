//global.grid.draw_grid();

if (update_fps >= 15)
{
    actual_fps  = fps_real;
    update_fps = 0;
}

draw_text(200,200, string(actual_fps));
draw_text(200,220, string(instance_number(obj_enemies)));