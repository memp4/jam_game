require daslib/media
require grid
require checker
require player_checker
// Make class from minigame
var grid1 = new Grid(5, 5, 100)

var player_checker = new Player_Checker(int2(1, 0), 0xc4c225)

var 
    checker1 = new Checker(int2(1, 1), player_checker.color)
    checker2 = new Checker(int2(2, 0), 0xffffff)
    checker3 = new Checker(int2(2, 1), 0xffffff)

var checkers: array<Checker?>

var coord_tab <- grid1 -> get_coords()

def minigame_init()
    push(checkers, checker1)
    push(checkers, checker2)
    push(checkers, checker3)
    return

def minigame_act()
    player_checker -> change_direction()
    player_checker -> set_position(coord_tab)
    for i in checkers
        i -> set_position(coord_tab)

    if get_key_up(VK_Q)
        if player_checker.direction == "up"
            for i in checkers
                if i.tab_pos == int2(player_checker.tab_pos.x, player_checker.tab_pos.y - 1)
                    i.tab_pos.y += 1
                    player_checker.tab_pos.y -= 1
        elif player_checker.direction == "right"
            for i in checkers
                if i.tab_pos == int2(player_checker.tab_pos.x + 1, player_checker.tab_pos.y)
                    i.tab_pos.x -= 1
                    player_checker.tab_pos.x += 1
        elif player_checker.direction == "down"
            for i in checkers
                if i.tab_pos == int2(player_checker.tab_pos.x, player_checker.tab_pos.y + 1)
                    i.tab_pos.y -= 1
                    player_checker.tab_pos.y += 1
        elif player_checker.direction == "left"
            for i in checkers
                if i.tab_pos == int2(player_checker.tab_pos.x - 1, player_checker.tab_pos.y)
                    i.tab_pos.x += 1
                    player_checker.tab_pos.x -= 1
    return

def minigame_draw()
    grid1 -> draw()
    for i in checkers
        i -> draw()
    player_checker -> draw()
    return

class Minigame
    grid: Grid
