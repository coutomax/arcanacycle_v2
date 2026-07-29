escalaX				= image_xscale;
escalaY				= image_yscale;

xscale				= escalaX;
yscale				= escalaY;

data                = undefined;
flexpanel_data      = false;

get_card_data   = function ()
{
    if (array_length(global.drawn_cards) <= 0) return;

    var _cards    = global.drawn_cards;
    data = _cards[0];
    array_delete(global.drawn_cards, 0, 1);
}

set_card_data  = function ()
{
    if (data == undefined) return;

    sprite_index    = data.sprite;
}

get_flexpanel_data = function ()
{
    if (data == undefined) return;
    if (flexpanel_data) return;

     // pega o node do painel de cartas
    root        = layer_get_flexpanel_node("ui_cards");
    container   = flexpanel_node_get_child(root, $"fp_container_{card_id}");

    //pega os dados para editar o nome da carta
    fp_name  = flexpanel_node_get_child(container, "fp_text_name");

    // pega a struct da layer
    fp_struct       = flexpanel_node_get_struct(fp_name);
    fp_element_id   = fp_struct.layerElements[0].elementId;
     
    layer_text_text(fp_element_id, data.name);
    flexpanel_data  = true;
}