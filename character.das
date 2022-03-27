require daslib/media
require sprite_utility


class Character
    position: float2
    size: float2
    sprite: ImageHandle

    sprite_grid: table<int; array<float4>>

    velocity: float = 400. // 90 is noraml
    tab_pos: int2 = int2(0, 1)

    fps: float = 12. // 12fps normally
    anim_timer: float 
    frame_start: int = 1
    frame: int
    frame_limit: int = 2

    is_collide: bool

    def Character(Position: float2; Size: float2; Sprite: string)
        Character`set(self, Position, Size, Sprite)
        return

    def set(Position: float2; Size: float2; Sprite: string)
        position = Position
        size = Size
        sprite <- create_managed_image(Sprite)
        
        sprite_grid <- sprite_grid(sprite, size)

        anim_timer = 1. / fps
        frame = frame_start
        return

    def animation(dt: float): int
        self.anim_timer -= dt
        if self.anim_timer <= 0.
            self.anim_timer = 1. / fps
            self.frame += 1
            if self.frame > self.frame_limit
                self.frame = 0
        return self.frame

    def act(dt: float)

        if get_key(VK_W)
            self.position.y -= self.velocity * dt
            self.tab_pos.x = 3
            self.tab_pos.y = self -> animation(dt)
        elif get_key(VK_D)
            self.position.x += self.velocity * dt
            self.tab_pos.x = 2
            self.tab_pos.y = self -> animation(dt)
        elif get_key(VK_S)
            self.position.y += self.velocity * dt
            self.tab_pos.x = 0
            self.tab_pos.y = self -> animation(dt)
        elif get_key(VK_A)
            self.position.x -= self.velocity * dt
            self.tab_pos.x = 1
            self.tab_pos.y = self -> animation(dt)
        else
            self.tab_pos.y = 1

        self.is_collide = false

        self.position.x = max(55., min(1350., self.position.x))
        self.position.y = max(55., min(720., self.position.y))
        return

    def draw()
        draw_image_region(self.sprite, self.position.x - self.size.x / 2., self.position.y - self.size.y / 2., 
            self.sprite_grid[self.tab_pos.x][self.tab_pos.y])
        return

    def collision(obj_position: float2; obj_size: float2): bool
        if (self.position.x + self.size.x < obj_position.x || 
            self.position.x + self.size.x > obj_position.x + obj_size.x)
            return false

        if (self.position.y + self.size.y < obj_position.y || 
            self.position.y + self.size.y >  obj_position.y + obj_size.y)
            return false

        return true

var half_height = float(get_screen_height() / 2)
var half_width = float(get_screen_width() / 2)

var robot = new Character(float2(half_width - 100., half_height - 100.), float2(48., 48.), "sprites/robot.png")
var cam_x: float
var cam_y: float

def character_init()
    return

def character_act(dt: float)
    robot -> act(dt)
    cam_x = max(0. + float(get_screen_width() / 4), 
        min(1408. - float(get_screen_width() / 4), robot.position.x))
    cam_y = max(0. + float(get_screen_height() / 4), 
        min(768. - float(get_screen_height() / 4), robot.position.y))
    
    setup_2d_camera(float2(cam_x, cam_y), 1.)
    return

def character_draw()
    enable_alpha_blend()
    robot -> draw()
    disable_alpha_blend()
    return