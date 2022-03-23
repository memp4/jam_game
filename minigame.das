require daslib/media
require grid
require checker
require player_checker
// Make class from minigame
class Minigame
    check_arr: array<Checker?>
    
    def Minigame(Check_arr: array<Checker?>)
        Minigame`set(self, Check_arr)
        return

    def set(Check_arr: array<Checker?>)
        check_arr <- check_arr
        return

var grid1 = new Grid(5, 5, 100)

var player_checker = new Player_Checker(int2(2, 2), 0xd48837)

var 
    checker1 = new Checker(int2(2, 0), 0xffffff)
    checker2 = new Checker(int2(2, 1), 0xffffff)
    checker3 = new Checker(int2(0, 2), 0xffffff)
    checker4 = new Checker(int2(1, 2), 0xffffff)
    checker5 = new Checker(int2(2, 3), 0xffffff)
    checker6 = new Checker(int2(3, 2), 0xffffff)

var checkers: array<Checker?>

var coord_tab <- grid1 -> get_coords()

var cl_minigame = new Minigame(checkers)

def minigame_init()
    push(checkers, checker1)
    push(checkers, checker2)
    push(checkers, checker3)
    push(checkers, checker4)
    push(checkers, checker5)
    push(checkers, checker6)
    return

def minigame_act()
    player_checker -> change_direction()
    player_checker -> set_position(coord_tab)
    for i in checkers
        i -> set_position(coord_tab)

    if get_key_up(VK_Q)
        swap(player_checker, checkers)
    elif get_key_up(VK_SPACE)
        jump(player_checker, checkers, grid1)
    return

def minigame_draw()
    grid1 -> draw()
    for i in checkers
        i -> draw()
    player_checker -> draw()
    return

def swap(var p_checker: Player_Checker?; var check_arr: array<Checker?>)
    if p_checker.direction == "up"
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y - 1)
                i.tab_pos.y += 1
                p_checker.tab_pos.y -= 1
                break

    elif p_checker.direction == "right"
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x + 1, p_checker.tab_pos.y)
                i.tab_pos.x -= 1
                p_checker.tab_pos.x += 1
                break

    elif p_checker.direction == "down"
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y + 1)
                i.tab_pos.y -= 1
                p_checker.tab_pos.y += 1
                break

    elif p_checker.direction == "left"
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x - 1, p_checker.tab_pos.y)
                i.tab_pos.x += 1
                p_checker.tab_pos.x -= 1
                debug(p_checker.tab_pos.x)
                break
    return

//This function makes makes jump for checkers
def jump(var p_checker: Player_Checker?; var check_arr: array<Checker?>; grid: Grid?)
    if p_checker.direction == "up"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y - 2)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y - 1) && i.color != p_checker.color && is_jump && i.tab_pos.y != 0
                p_checker.tab_pos.y -= 2
                i.color = p_checker.color
                break

    elif p_checker.direction == "right"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x + 2, p_checker.tab_pos.y)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x + 1, p_checker.tab_pos.y) && i.color != p_checker.color && is_jump && i.tab_pos.x != grid.columns - 1
                p_checker.tab_pos.x += 2
                i.color = p_checker.color
                break

    elif p_checker.direction == "down"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y + 2)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x, p_checker.tab_pos.y + 1) && i.color != p_checker.color && is_jump && i.tab_pos.y != grid.rows - 1
                p_checker.tab_pos.y += 2
                i.color = p_checker.color
                break

    elif p_checker.direction == "left"
        var is_jump = true
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x - 2, p_checker.tab_pos.y)
                is_jump = false
        for i in check_arr
            if i.tab_pos == int2(p_checker.tab_pos.x - 1, p_checker.tab_pos.y) && i.color != p_checker.color && is_jump && i.tab_pos.x != 0
                p_checker.tab_pos.x -= 2
                i.color = p_checker.color
                break
    return