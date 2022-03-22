require daslib/media

class Player_Checker
    position: int2
    radius: int = 20
    color: uint
    direction: string = "up"

    def Player_Checker(Position: int2; Radius: int; Color: uint)
        Player_Checker`set(self, Position, Radius, Color)
        return
    
    def set(Position: int2; Radius: int; Color: uint)
        position = Position
        radius = Radius
        color = Color
        return

    def info()
        debug(self)
        return
    
    def set_direction(arrow: string)
        self.direction = arrow
    
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