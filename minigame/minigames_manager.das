require daslib/media
require grid
require checker
require player_checker
require minigame

// First game
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

var minitable <- {{
    "minigame 1" => m1_minigame;
    "minigame 2" => m2_minigame
    }}

def minigame_init()
    return

def minigame_act()
    m_update(minitable["minigame 1"])
    return

def minigame_draw()
    m_visual(minitable["minigame 1"])
    return

def m_visual(var minigame: Minigame?)
    if minigame.isFinished == true
        text_out(get_screen_width() / 2 - 40, 100, "You Win", 0xffffff)
    else
        minigame -> draw()
    return

def m_update(var minigame: Minigame?)
    if minigame.isFinished == true
        return
    else
        minigame -> update()
    return