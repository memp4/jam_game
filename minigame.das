require daslib/media
require grid
require checker
require player_checker
// Make class from minigame
var grid1 = new Grid(5, 5, 100)
var checker_arr: array<Checker?>
var checker1 = new Checker()
var player_checker = new Player_Checker() 

def minigame_init()
    var tab <- grid1 -> get_coords()
    checker1.position = tab[1][2]
    checker1.color = 0xffffff
    player_checker.position = tab[0][0]
    player_checker.color = 0xc4c225
    return

def minigame_act(dt: float)
    return

def minigame_draw()
    grid1 -> draw()
    checker1 -> draw()
    player_checker -> draw()
    return