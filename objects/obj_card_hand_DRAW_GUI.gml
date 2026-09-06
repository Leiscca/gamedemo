/// obj_card_hand -- Draw GUI Event
/// Drawn in GUI space so the row stays fixed to the screen regardless
/// of camera / room position.

var _count = array_length(hand);
var _total_w = _count * (card_width + card_spacing) - card_spacing;
var _start_x = (display_get_gui_width() - _total_w) / 2;
var _base_y  = display_get_gui_height() - card_height - bottom_margin;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < _count; i++) {
    var _c = hand[i];

    var _x = _start_x + i * (card_width + card_spacing);
    var _y = _base_y;

    // raise the card slightly on hover
    var _raise = _c.hover ? 10 : 0;
    _y -= _raise;

    // store the hitbox for THIS frame's draw position
    // (kept slightly generous so the raised card is still easy to click)
    _c.x1 = _x;
    _c.y1 = _y;
    _c.x2 = _x + card_width;
    _c.y2 = _y + card_height;

    // card background
    draw_set_alpha(1);
    draw_rectangle_color(_x, _y, _c.x2, _c.y2, _c.color, _c.color, _c.color, _c.color, false);

    // border (thicker + brighter on hover)
    draw_set_alpha(1);
    if (_c.hover) {
        draw_set_color(c_white);
        draw_rectangle(_x - 2, _y - 2, _c.x2 + 2, _c.y2 + 2, true);
    } else {
        draw_set_color(c_black);
        draw_rectangle(_x, _y, _c.x2, _c.y2, true);
    }

    // label (swap this for draw_sprite with your icon, then draw_text below it)
    draw_set_color(c_black);
    draw_text(_x + card_width / 2, _y + card_height / 2, _c.name);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
