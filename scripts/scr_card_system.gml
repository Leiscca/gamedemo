/// scr_card_system.gml
/// Helper functions for creating card data and managing a hand of cards.
/// Paste each function below into its own Script resource (recommended),
/// or into one Script resource named "scr_card_system" that holds all of them.

/// @function make_card(_name, _color, _icon, _action)
/// @description Creates a single card as a struct. Cards are plain data
/// until they are drawn/clicked - no instances are created for them.
/// @param {string} _name    Label shown on the card
/// @param {real}   _color   Fill color (use make_color_rgb or a hex constant)
/// @param {string} _icon    Optional: sprite name or icon key you draw yourself
/// @param {function} _action Function to run when the card is clicked
function make_card(_name, _color, _icon, _action) {
    return {
        name: _name,
        color: _color,
        icon: _icon,
        action: _action,
        // hitbox, filled in every frame by the draw code
        x1: 0, y1: 0, x2: 0, y2: 0,
        // used for hover animation
        hover: false
    };
}

/// @function card_hand_handle_click(_hand, _mx, _my)
/// @description Checks a hand array against a mouse position (GUI space)
/// and runs the clicked card's action if one is hit.
/// @param {array} _hand  Array of card structs (from make_card)
/// @param {real}  _mx    Mouse x in GUI space
/// @param {real}  _my    Mouse y in GUI space
/// @returns {bool} true if a card was clicked
function card_hand_handle_click(_hand, _mx, _my) {
    for (var i = 0; i < array_length(_hand); i++) {
        var _c = _hand[i];
        if (_mx >= _c.x1 && _mx <= _c.x2 && _my >= _c.y1 && _my <= _c.y2) {
            _c.action();
            return true;
        }
    }
    return false;
}

/// @function card_hand_update_hover(_hand, _mx, _my)
/// @description Updates the .hover flag on every card based on mouse position.
/// Call this every step before drawing so the draw event can raise/highlight
/// the hovered card.
function card_hand_update_hover(_hand, _mx, _my) {
    for (var i = 0; i < array_length(_hand); i++) {
        var _c = _hand[i];
        _c.hover = (_mx >= _c.x1 && _mx <= _c.x2 && _my >= _c.y1 && _my <= _c.y2);
    }
}
