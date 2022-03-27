require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require minigame/minigames_manager
require character
require objects_manager
require col_object
require message

var map <- create_managed_image("sprites/map.png")
var gamestate: string = "play"
var minigame_choice: string

[export]
def initialize()
    set_window_title("Jam Game")

    set_font_name("fonts/Robot Crush.ttf")
    // set_font_size(8)
    return

[export]
def act(dt: float)
    if gamestate == "play"
        character_act(dt)
        objects_act()
    elif gamestate == "minigame"
        minigame_act(minigame_choice)
    
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    return

[export]
def draw()
    if gamestate == "play"
        draw_image(map, 0, 0)
        objects_draw()
        character_draw()
    elif gamestate == "minigame"
        setup_2d_camera(float2(get_screen_width() / 2, get_screen_height() / 2), 1.0)
        minigame_draw(minigame_choice)
    return

def objects_act()
    mess1.isVisible = false
    mess2.isVisible = false
    if robot -> collision(tree.position, tree.size)
        mess1.isVisible = true
    elif robot -> collision(bonfire.position, bonfire.size)
        mess2.isVisible = true
    elif robot -> collision(rock.position, rock.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 1"
    elif robot -> collision(pit.position, pit.size)
        mess2.isVisible = true
    elif robot -> collision(bush.position, bush.size)
        mess2.isVisible = true

    mess1 -> stick(robot.position, robot.size)
    mess2 -> stick(robot.position, robot.size)
    return


def minigame_act(minigame_choice: string)
    if minitable[minigame_choice].isFinished == true
        if get_key_up(VK_E)
            gamestate = "play"
    else
        minitable[minigame_choice] -> update()
    return