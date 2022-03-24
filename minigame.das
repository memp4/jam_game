require daslib/media
require grid
require checker
require player_checker

class Minigame
    p_checker: Player_Checker?
    check_arr: array<Checker?>
    grid: Grid?

    start_p_pos: int2
    start_checks_pos: array<int2>
    start_checks_colors: array<uint>

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

        start_p_pos := p_checker.tab_pos
        for i in check_arr 
            push(start_checks_pos, i.tab_pos) 
            push(start_checks_colors, i.color)
        return

    def reset()
        self.p_checker.tab_pos := start_p_pos
        for i in range(length(check_arr))
            check_arr[i].tab_pos := start_checks_pos[i]
            check_arr[i].color := start_checks_colors[i]

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
        elif get_key_up(VK_R)
            self -> reset()

        self -> check_finish()
        return

    def draw()
        self.grid -> draw()

        for i in self.check_arr
            i -> draw()

        self.p_checker -> draw()
        return
