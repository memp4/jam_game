require daslib/media

class Checker
    position: int2
    radius: int = 20
    color: uint

    def Checker(Position: int2; Radius: int; Color: uint)
        Checker`set(self, Position, Radius, Color)
    
    def set(Position: int2; Radius: int; Color: uint)
        position = Position
        radius = Radius
        color = Color

    def info()
        debug(self)
    
    def draw()
        fill_circle(self.position.x, self.position.y, self.radius, self.color)