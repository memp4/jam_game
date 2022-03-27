require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require minigame/minigames_manager
require character
require objects_manager
require col_object
require message

var map <- create_managed_image("sprites/map.png")

var message <- create_managed_image("sprites/message.png")
var mess1 = new Message_win(robot.position, float2(400., 80.), "sprites/message.png")
var tex1 = "Hello this is first text :)"

var tree = new Col_object(float2(19. * 32., 11. * 32.), float2(7. * 32., 5. * 32.))
var bonfire = new Col_object(float2(32. * 32., 19. * 32.), float2(4. * 32., 4. * 32.))
var rock = new Col_object(float2(5. * 32., 13. * 32.), float2(7. * 32., 7. * 32.))
var pit = new Col_object(float2(2. * 32., 3. * 32.), float2(3. * 32., 3. * 32.))
var bush = new Col_object(float2(35. * 32., 2. * 32.), float2(6. * 32., 4. * 32.))

[export]
def initialize()
    set_window_title("Jam Game")
    // minigame_init()
    character_init()
    objects_init()

    set_font_name("fonts/Robot Crush.ttf")
    // set_font_size(8)
    mess1.text = tex1
    return

[export]
def act(dt: float)
    // minigame_act()
    character_act(dt)
    objects_init()
    mess1.isVisible = false
    if robot -> collision(tree.position, tree.size)
        mess1.isVisible = true

    mess1 -> stick(robot.position, robot.size)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    return

[export]
def draw()
    // minigame_draw()
    draw_image(map, 0, 0)
    objects_draw()
    mess1 -> draw()
    character_draw()

    tree -> draw()
    bonfire -> draw()
    rock -> draw()
    pit -> draw()
    bush -> draw()
    return