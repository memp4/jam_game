require daslib/media

class Player_Checker
    tab_pos: int2
    color: uint

    position: int2
    radius: int = 20
    direction: string = "right"

    def Player_Checker(Tab_pos: int2; Color: uint)
        Player_Checker`set(self, Tab_pos, Color)
        return
    
    def set(Tab_pos: int2; Color: uint)
        tab_pos = Tab_pos
        color = Color
        return
    
    def set_position(var tab: table<int; array<int2>>)
        self.position = tab[self.tab_pos.y][self.tab_pos.x]

    def set_direction(arrow: string)
        self.direction = arrow
    
    def change_direction()
        if get_key_up(VK_W)
            set_direction("up")
        elif get_key_up(VK_D)
            set_direction("right")
        elif get_key_up(VK_S)
            set_direction("down")
        elif get_key_up(VK_A)
            set_direction("left")
                  
    
    def draw()
        fill_circle(self.position.x, self.position.y, self.radius, self.color)
        if self.direction == "up"
            line(self.position.x, self.position.y, self.position.x, self.position.y - radius, self.color - 0x555555)
            for i in range(-4, 4)
                line(self.position.x + i, self.position.y, self.position.x, self.position.y - radius, self.color - 0x555555)
        elif self.direction == "right"
            line(self.position.x, self.position.y, self.position.x + radius, self.position.y, self.color - 0x555555)
            for i in range(-4, 4)
                line(self.position.x, self.position.y + i, self.position.x + radius, self.position.y, self.color - 0x555555)
        elif self.direction == "down"
            line(self.position.x, self.position.y, self.position.x, self.position.y + radius, self.color - 0x555555)
            for i in range(-4, 4)
                line(self.position.x + i, self.position.y, self.position.x, self.position.y + radius, self.color - 0x555555)
        elif self.direction == "left"
            line(self.position.x, self.position.y, self.position.x - radius, self.position.y, self.color - 0x555555)
            for i in range(-4, 4)
                line(self.position.x, self.position.y + i, self.position.x - radius, self.position.y, self.color - 0x555555)
        return