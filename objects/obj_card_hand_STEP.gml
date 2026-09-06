/// obj_card_hand -- Step Event

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// update hover state (used by the draw event to raise/highlight a card)
card_hand_update_hover(hand, _mx, _my);

// handle click
if (mouse_check_button_pressed(mb_left)) {
    card_hand_handle_click(hand, _mx, _my);
}
