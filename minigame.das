require daslib/media
require grid
require checker
require player_checker
// Make class from minigame
class Minigame
    p_checker: Player_Checker?
    check_arr: array<Checker?>
    grid: Grid?

    coord_tab: table<int; array<int2>>
    isFinished: bool = false
    
    def Minigame(P_checker: Player_Checker?; var Check_arr: array<Checker?>; Grid: Grid?)
        Minigame`set(self, P_checker, Check_arr, Grid)
        return

    def set(P_checker: Player_Checker?; var Check_arr: array<Checker?>; Grid: Grid?)
        p_checker = P_checker
        check_arr <- Check_arr
        grid = Grid

        coord_tab <- grid -> get_coords()
        return

    def swap()
        if self.p_checker.direction == "up"
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x, self.p_checker.tab_pos.y - 1)
                    i.tab_pos.y += 1
                    self.p_checker.tab_pos.y -= 1
                    break

        elif self.p_checker.direction == "right"
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x + 1, self.p_checker.tab_pos.y)
                    i.tab_pos.x -= 1
                    self.p_checker.tab_pos.x += 1
                    break

        elif self.p_checker.direction == "down"
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x, self.p_checker.tab_pos.y + 1)
                    i.tab_pos.y -= 1
                    self.p_checker.tab_pos.y += 1
                    break

        elif self.p_checker.direction == "left"
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x - 1, self.p_checker.tab_pos.y)
                    i.tab_pos.x += 1
                    self.p_checker.tab_pos.x -= 1
                    break
        return

    def jump()
        if self.p_checker.direction == "up"
            var is_jump = true
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x, self.p_checker.tab_pos.y - 2)
                    is_jump = false
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x, self.p_checker.tab_pos.y - 1) && i.color != self.p_checker.color && is_jump && i.tab_pos.y != 0
                    self.p_checker.tab_pos.y -= 2
                    i.color = self.p_checker.color
                    break

        elif self.p_checker.direction == "right"
            var is_jump = true
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x + 2, self.p_checker.tab_pos.y)
                    is_jump = false
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x + 1, self.p_checker.tab_pos.y) && i.color != self.p_checker.color && is_jump && i.tab_pos.x != self.grid.columns - 1
                    self.p_checker.tab_pos.x += 2
                    i.color = self.p_checker.color
                    break

        elif self.p_checker.direction == "down"
            var is_jump = true
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x, self.p_checker.tab_pos.y + 2)
                    is_jump = false
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x, self.p_checker.tab_pos.y + 1) && i.color != self.p_checker.color && is_jump && i.tab_pos.y != self.grid.rows - 1
                    self.p_checker.tab_pos.y += 2
                    i.color = self.p_checker.color
                    break

        elif self.p_checker.direction == "left"
            var is_jump = true
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x - 2, self.p_checker.tab_pos.y)
                    is_jump = false
            for i in self.check_arr
                if i.tab_pos == int2(self.p_checker.tab_pos.x - 1, self.p_checker.tab_pos.y) && i.color != self.p_checker.color && is_jump && i.tab_pos.x != 0
                    self.p_checker.tab_pos.x -= 2
                    i.color = self.p_checker.color
                    break
        return
    
    def check_finish()
        self.isFinished = true
        for i in self.check_arr
            if i.color != self.p_checker.color
                self.isFinished = false

    def update()
        self.p_checker -> change_direction()
        self.p_checker -> set_position(self.coord_tab)
        for i in self.check_arr
            i -> set_position(self.coord_tab)

        if get_key_up(VK_Q)
            self -> swap()
        elif get_key_up(VK_SPACE)
            self -> jump()

        self -> check_finish()
        return

    def draw()
        self.grid -> draw()

        for i in self.check_arr
            i -> draw()

        self.p_checker -> draw()
        return

var grid1 = new Grid(5, 2, 100)

var player_checker = new Player_Checker(int2(1, 0), 0xd48837)

var 
    checker1 = new Checker(int2(1, 1), player_checker.color)
    checker2 = new Checker(int2(2, 0), 0xffffff)
    checker3 = new Checker(int2(2, 1), 0xffffff)

var checkers: array<Checker?>

var cl_minigame = new Minigame(player_checker, checkers, grid1)

def minigame_init()
    push(checkers, checker1)
    push(checkers, checker2)
    push(checkers, checker3)
    cl_minigame.check_arr <- checkers
    debug(cl_minigame)
    return

def minigame_act()
    cl_minigame -> update()
    return

def minigame_draw()
    if cl_minigame.isFinished == true
        text_out(500, 100, "You Win", 0xffffff)
    else
        cl_minigame -> draw()
    return