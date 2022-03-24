require daslib/media
require player_checker

class Checker
    tab_pos: int2
    color: uint

    position: int2
    radius: int = 20

    def Checker(Tab_pos:int2; Color: uint)
        Checker`set(self, Tab_pos, Color)
        return

    def set(Tab_pos:int2; Color: uint)
        tab_pos = Tab_pos
        color = Color
        return

    def set_position(var tab: table<int; array<int2>>)
        self.position = tab[self.tab_pos.y][self.tab_pos.x]
    
    def draw()
        fill_circle(self.position.x, self.position.y, self.radius, self.color)
        return