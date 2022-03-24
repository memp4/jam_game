require daslib/media
require sprite_utility

class Character
    position: float2
    size: float2
    sprite: ImageHandle

    sprite_grid: table<int; array<float4>>

    velocity: float = 300.
    tab_pos: int2 = int2(0, 1)

    def Character(Position: float2; Size: float2; Sprite: string)
        Character`set(self, Position, Size, Sprite)
        return

    def set(Position: float2; Size: float2; Sprite: string)
        position = Position
        size = Size
        sprite <- create_managed_image(Sprite)
        
        sprite_grid <- sprite_grid(sprite, size)
        return

    def draw()
        draw_image_region(self.sprite, self.position.x, self.position.y, self.sprite_grid[self.tab_pos.x][self.tab_pos.y])
        return

var robot = new Character(float2(50., 50.), float2(48., 48.), "sprites/robot.png")

def character_init()
    return

def character_act()
    return

def character_draw()
    enable_alpha_blend()
    robot -> draw()
    disable_alpha_blend()
    return