/// obj_card_hand -- Create Event
/// This object is the controller for the bottom card row.
/// Put ONE instance of it in your room (e.g. via the room editor,
/// or instance_create_layer in a persistent controller).

// --- layout settings ---
card_width   = 90;
card_height  = 120;
card_spacing = 14;
bottom_margin = 24;

// --- build the hand ---
// Replace these with your real game actions. Each "action" is a function
// that runs immediately when the card is clicked.
hand = [
    make_card("Dash", make_color_rgb(127, 119, 221), "spr_icon_dash", function() {
        with (obj_player) {
            speed = 8;
            alarm[0] = 15; // reset speed back to normal after 15 steps, if you add that alarm
        }
        show_debug_message("Dash triggered");
    }),

    make_card("Heal", make_color_rgb(29, 158, 117), "spr_icon_heal", function() {
        if (instance_exists(obj_player)) {
            obj_player.hp = min(obj_player.hp + 20, obj_player.hp_max);
        }
        show_debug_message("Heal triggered");
    }),

    make_card("Attack", make_color_rgb(216, 90, 48), "spr_icon_attack", function() {
        if (instance_exists(obj_player)) {
            instance_create_layer(obj_player.x, obj_player.y, "Effects", obj_slash);
        }
        show_debug_message("Attack triggered");
    }),

    make_card("Guard", make_color_rgb(212, 83, 126), "spr_icon_guard", function() {
        if (instance_exists(obj_player)) {
            obj_player.guarding = true;
        }
        show_debug_message("Guard triggered");
    })
];
