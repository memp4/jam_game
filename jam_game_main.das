require daslib/media
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code
require minigame/minigames_manager
require character
require objects_manager
require col_object

var map <- create_managed_image("sprites/map.png")

var tree = new Col_object(float2(19. * 32., 11. * 32.), float2(7. * 32., 5. * 32.))
var bonfire = new Col_object(float2(32. * 32., 19. * 32.), float2(4. * 32., 4. * 32.))
var rock = new Col_object(float2(5. * 32., 13. * 32.), float2(7. * 32., 7. * 32.))
var pit = new Col_object(float2(2. * 32., 3. * 32.), float2(3. * 32., 3. * 32.))
var bush = new Col_object(float2(35. * 32., 2. * 32.), float2(6. * 32., 4. * 32.))

[export]
def initialize()
    set_window_title("Jam Game")
    debug(map.width)
    debug(map.height)
    // minigame_init()
    character_init()
    // col_object_init()
    return

[export]
def act(dt: float)
    // minigame_act()
    character_act(dt)
    // col_object_update()

    if robot -> collision(tree.position, tree.size)
        print("tree\n")

    if get_key(VK_ESCAPE)
        schedule_quit_game()
    return

[export]
def draw()
    // minigame_draw()
    draw_image(map, 0, 0)
    // col_object_draw()
    character_draw()

    tree -> draw()
    bonfire -> draw()
    rock -> draw()
    pit -> draw()
    bush -> draw()
    return