require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require minigame/grid
require minigame/checker
require minigame/player_checker
require minigame/minigame
require character
require col_object
require message

//Core game
var map <- create_managed_image("sprites/map.png")
var gamestate: string = "play"
var minigame_choice: string

//Objects
var message <- create_managed_image("sprites/message.png")
var genes_amount: int = 4
var tex1: string
var mess1 = new Message(robot.position, float2(180., 60.), "sprites/message.png", tex1)

var tex2 = "\t\tGene here!\n\t\tPress E"
var mess2 = new Message(robot.position, float2(180., 60.), "sprites/message.png", tex2)

var
    tree = new Col_object(float2(19. * 32., 11. * 32.), float2(7. * 32., 5. * 32.))
    bonfire = new Col_object(float2(32. * 32., 19. * 32.), float2(4. * 32., 4. * 32.))
    rock = new Col_object(float2(5. * 32., 13. * 32.), float2(7. * 32., 7. * 32.))
    pit = new Col_object(float2(2. * 32., 3. * 32.), float2(3. * 32., 3. * 32.))
    bush = new Col_object(float2(35. * 32., 2. * 32.), float2(6. * 32., 4. * 32.))

//Minigames
var m1_grid = new Grid(5, 2, 100)
var m1_p_checker = new Player_Checker(int2(1, 0), 0xd48837)
var 
    m1_checker1 = new Checker(int2(1, 1), m1_p_checker.color)
    m1_checker2 = new Checker(int2(2, 0), 0xffffff)
    m1_checker3 = new Checker(int2(2, 1), 0xffffff)

var m1_check_arr <- [{auto m1_checker1; m1_checker2; m1_checker3}]
var m1_minigame = new Minigame(m1_p_checker, m1_check_arr, m1_grid)

//Second game
var m2_grid = new Grid(4, 4, 100)
var m2_p_checker = new Player_Checker(int2(1, 1), 0x2b84f0)
var 
    m2_checker1 = new Checker(int2(0, 0), 0xffffff)
    m2_checker2 = new Checker(int2(1, 2), 0xffffff)
    m2_checker3 = new Checker(int2(2, 1), 0xffffff)
    m2_checker4 = new Checker(int2(0, 2), 0xffffff)

var m2_check_arr <- [{auto m2_checker1; m2_checker2; m2_checker3; m2_checker4}]
var m2_minigame = new Minigame(m2_p_checker, m2_check_arr, m2_grid)

//Third game
var m3_grid = new Grid(5, 5, 100)
var m3_p_checker = new Player_Checker(int2(2, 2), 0x18134c)
var 
    m3_checker1 = new Checker(int2(2, 1), 0xffffff)
    m3_checker2 = new Checker(int2(3, 1), 0xffffff)
    m3_checker3 = new Checker(int2(1, 2), 0xffffff)
    m3_checker4 = new Checker(int2(2, 3), 0xffffff)
    m3_checker5 = new Checker(int2(3, 3), 0xffffff)
    m3_checker6 = new Checker(int2(2, 4), m3_p_checker.color)
    m3_checker7 = new Checker(int2(3, 4), 0xffffff)

var m3_check_arr <- [{auto m3_checker1; m3_checker2; m3_checker3; m3_checker4;
    m3_checker5; m3_checker6; m3_checker7}]

var m3_minigame = new Minigame(m3_p_checker, m3_check_arr, m3_grid)

//Fourth fame
var m4_grid = new Grid(7, 2, 100)
var m4_p_checker = new Player_Checker(int2(0, 0), 0x2b84f0)
var 
    m4_checker1 = new Checker(int2(1, 0), 0xffffff)
    m4_checker2 = new Checker(int2(3, 0), 0xffffff)
    m4_checker3 = new Checker(int2(5, 0), 0xffffff)
    m4_checker4 = new Checker(int2(1, 1), 0xffffff)
    m4_checker5 = new Checker(int2(2, 1), m4_p_checker.color)
    m4_checker6 = new Checker(int2(3, 1), 0xffffff)
    m4_checker7 = new Checker(int2(5, 1), 0xffffff)
    m4_checker8 = new Checker(int2(6, 1), m4_p_checker.color)

var m4_check_arr <- [{auto m4_checker1; m4_checker2; m4_checker3; m4_checker4;
    m4_checker5; m4_checker6; m4_checker7; m4_checker8}]
var m4_minigame = new Minigame(m4_p_checker, m4_check_arr, m4_grid)

var minitable <- {{
    "minigame 1" => m1_minigame;
    "minigame 2" => m2_minigame;
    "minigame 3" => m3_minigame;
    "minigame 4" => m4_minigame
    }}

[export]
def initialize()
    set_window_title("Jam Game")

    set_font_name("fonts/Robot Crush.ttf")
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

//Objects function
def objects_act()
    mess1.isVisible = false
    mess2.isVisible = false
    if robot -> collision(tree.position, tree.size)
        mess1.isVisible = true
    elif robot -> collision(bonfire.position, bonfire.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 3"
    elif robot -> collision(rock.position, rock.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 1"
    elif robot -> collision(pit.position, pit.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 2"
    elif robot -> collision(bush.position, bush.size)
        mess2.isVisible = true
        if get_key_up(VK_E)
            gamestate = "minigame"
            minigame_choice = "minigame 4"

    genes_amount = minigames_check()
    if genes_amount == 0
        mess1.text = "\t\tGene here!\n\t\tPress E"
    else
        mess1.text = "\t\tFind 4 genes\n\t\t{genes_amount}/4"
    mess1 -> stick(robot.position, robot.size)
    mess2 -> stick(robot.position, robot.size)
    return


def objects_draw()
    mess1 -> draw()
    mess2 -> draw()
    return

//Minigame functions
def minigame_act(minigame_choice: string)
    if minitable[minigame_choice].isFinished == false
        minitable[minigame_choice] -> update()

    if get_key_up(VK_E)
        gamestate = "play"
    return

def minigame_draw(minigame_choice: string)
    fill_rect(0, 0, get_screen_width(), get_screen_height(), 0x064e51)
    if minitable[minigame_choice].isFinished == true
        text_out(get_screen_width() / 2 - 40, 100, "You Win", 0xffffff)
    else
        minitable[minigame_choice] -> draw()
    return

def minigames_check(): int
    var amount = 0
    for i in range(1, 5)
        if minitable["minigame {i}"].isFinished != true
            amount++
    return amount