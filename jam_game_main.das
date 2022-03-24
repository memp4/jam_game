require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require sprite_utility
require minigames_manager

[export]
def initialize()
    set_window_title("Jam Game")
    minigame_init()
    return

[export]
def act(dt: float)
    minigame_act()
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    return

[export]
def draw()
    fill_rect(0, 0, get_screen_width(), get_screen_height(), 0x34495E)
    minigame_draw()
    return