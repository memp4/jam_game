require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require minigame/minigames_manager
require character

var map <- create_managed_image("sprites/map.png")

[export]
def initialize()
    set_window_title("Jam Game")
    debug(map.width)
    debug(map.height)
    // minigame_init()
    character_init()
    return

[export]
def act(dt: float)
    // minigame_act()
    character_act(dt)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    return

[export]
def draw()
    // minigame_draw()
    draw_image(map, 0, 0)
    character_draw()
    return