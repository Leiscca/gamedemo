# GameMaker card row demo (cards only)

This is a minimal, self-contained implementation of a bottom-of-screen
action card row: a row of cards, each with an action, triggered on click,
with a hover-raise effect. It does not include a player, world, or any
other game systems — just the card mechanic, so you can drop it into
an existing project.

I can't export a compiled `.yyp` GameMaker project file from here (that
requires the GameMaker IDE itself), so this is delivered as the raw GML
code for each event, organized the way GameMaker organizes resources.
Setup takes about 5 minutes.

## Files

```
scripts/
  scr_card_system.gml       -> helper functions (make_card, click/hover handling)
objects/
  obj_card_hand_CREATE.gml   -> Create Event code
  obj_card_hand_STEP.gml     -> Step Event code
  obj_card_hand_DRAW_GUI.gml -> Draw GUI Event code
```

## Setup steps

1. **Create the script.**
   In the GameMaker IDE: right-click **Scripts** → **Create Script**,
   name it `scr_card_system`. Paste in the contents of
   `scripts/scr_card_system.gml`.

2. **Create the controller object.**
   Right-click **Objects** → **Create Object**, name it `obj_card_hand`.
   No sprite is required (it draws rectangles + text for now).

3. **Add the events.**
   In `obj_card_hand`, add:
   - **Create Event** → paste `objects/obj_card_hand_CREATE.gml`
   - **Step Event** → paste `objects/obj_card_hand_STEP.gml`
   - **Draw GUI Event** → paste `objects/obj_card_hand_DRAW_GUI.gml`
     (Add Event → Draw → Draw GUI)

4. **Place it in a room.**
   Drag one instance of `obj_card_hand` into your room (position doesn't
   matter — it draws in GUI space, fixed to the screen).

5. **Run the game.**
   You should see 4 cards at the bottom of the screen. Hovering raises
   a card; clicking it runs its action and prints a debug message
   (View → Output / the debug console).

## Wiring in your real actions

Each card's third argument is a plain GML function — put your real game
logic there:

```gml
make_card("Heal", make_color_rgb(29, 158, 117), "spr_icon_heal", function() {
    obj_player.hp += 20;
})
```

The demo's Create event references `obj_player`, `obj_slash`, `hp`,
`hp_max`, and `guarding` as placeholders — replace those with whatever
your actual player object exposes, or just leave `show_debug_message(...)`
in place while you test the card row on its own.

## Swapping rectangles for real card art

In `obj_card_hand_DRAW_GUI.gml`, replace the `draw_rectangle_color` /
`draw_text` block with `draw_sprite_stretched(spr_card_bg, 0, _x, _y,
card_width, card_height)` plus `draw_sprite(_c.icon, 0, ...)` once you
have card sprites — the hitbox and hover-raise logic don't need to change.

## Removing a card after use

If a card should be consumed on click (not reusable), delete it from the
hand after its action runs. In `card_hand_handle_click` (in the script),
change:

```gml
if (_mx >= _c.x1 && _mx <= _c.x2 && _my >= _c.y1 && _my <= _c.y2) {
    _c.action();
    return true;
}
```

to:

```gml
if (_mx >= _c.x1 && _mx <= _c.x2 && _my >= _c.y1 && _my <= _c.y2) {
    _c.action();
    array_delete(_hand, i, 1);
    return true;
}
```
